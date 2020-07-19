#!/usr/bin/env python3

import os
import sys
import glob
import pathlib
import yaml
import subprocess
import plac


def touch(path):
    """
    Update last time modified attribute for a given file.
    If the file does not exist, it will be created.
    """
    with open(path, 'a'):
        os.utime(path, None)


def get_datadir():

    """
    Return a parent directory path where persistent application data
    can be stored.

    # linux: ~/.local/share
    # macOS: ~/Library/Application Support
    # windows: C:/Users/<USER>/AppData/Roaming
    """

    home = pathlib.Path.home()

    if sys.platform.startswith('win'):
        return home / 'AppData/Roaming'

    if sys.platform.startswith('linux'):
        return home / '.local/share'

    if sys.platform.startswith('darwin'):
        return home / 'Library/Application Support'

    raise ValueError('Platform not supported: ' + sys.platform)


def create_datadir():
    """
    Create a directory where persistent application data can be stored.
    """
    datadir = get_datadir() / 'docker-dev-services'

    if not(os.path.exists(datadir)):
        datadir.mkdir(parents=True)

    return datadir


def get_active_instance_path():
    data_dir = create_datadir()
    return os.path.join(data_dir, '.active-set')


def set_active_instance(name):
    path = get_active_instance_path()
    with open(path, 'wt') as file:
        file.write(name)


def get_active_instance():
    path = get_active_instance_path()
    if not(os.path.exists(path)):
        return ''

    with open(path, 'rt') as file:
        return file.read()


def clear_active_instance():
    path = get_active_instance_path()
    with open(path, 'wt') as file:
        return file.write('')


def get_service_sets(base_dir):
    service_sets_dir = os.path.join(base_dir, 'service-sets')
    return glob.glob(service_sets_dir, '*.yaml')


def get_service_set_services(base_dir, name):
    path = os.path.join(base_dir, 'service-sets', "{}.yaml".format(name))
    if not(os.path.exists(path)):
        return []
    with open(path) as file:
        doc = yaml.load(file, Loader=yaml.SafeLoader)
        return doc['services']


def create_service_set_local_env(base_dir, name):
    local_env_dir = os.path.join(base_dir, '.env')
    if not(os.path.exists(local_env_dir)):
        os.makedirs(local_env_dir)
    service_set_services = get_service_set_services(base_dir, name)
    for x in service_set_services:
        local_env_file = os.path.join(local_env_dir, "{}.env".format(x))
        if not(os.path.exists(local_env_file)):
            touch(local_env_file)


def get_docker_compose_parameters(base_dir, set_name):
    service_set_services = get_service_set_services(base_dir, set_name)
    params = ['-p', set_name, '-f', 'services/network.yaml']
    for s in service_set_services:
        params += ['-f', "services/{}/service.yaml".format(s)]
    return params


def run_docker_compose(base_dir, args):
    result = subprocess.run(['docker-compose'] + args,
                            check=True, cwd=base_dir)
    if not(result.returncode == 0):
        raise AssertionError('docker-compose failed: ' + result.stderr)


############################################################
# Entry point

@plac.pos('action', "Action", choices=['start', 'stop'])
@plac.opt('name', "Service set name")
def main(action, name='default'):
    """
    Start/Stop set of infrastructure services using Docker Compose
    """
    base_dir = os.getcwd()
    params = get_docker_compose_parameters(base_dir, name)

    active_instance = get_active_instance()

    if action == 'start':
        params += ['up', '-d']
        if active_instance and not(active_instance == name):
            raise ValueError(
                    "Cannot start set '{}'. Set '{}' is already active."
                    .format(name, active_instance))
    else:
        if action == 'stop':
            params += ['down']
        else:
            raise ValueError("Action {} is not supported".format(action))
    create_service_set_local_env(base_dir, name)
    run_docker_compose(base_dir, params)


if __name__ == '__main__':
    plac.call(main)
