# Copyright 2022 Red Hat Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Clowder integration functions."""
import yaml
from app_common_python import LoadedConfig


def apply_clowder_config(manifest):
    """Apply Clowder config values to ICM config manifest."""
    Loader = getattr(yaml, "CSafeLoader", yaml.SafeLoader)
    config = yaml.load(manifest, Loader=Loader)
    kafka_url = f"{LoadedConfig.kafka.brokers[0].hostname}:{LoadedConfig.kafka.brokers[0].port}"
    config["service"]["consumer"]["kwargs"]["bootstrap_servers"] = kafka_url
    config["service"]["publisher"]["kwargs"]["bootstrap_servers"] = kafka_url
    pt_watcher = "ccx_messaging.watchers.payload_tracker_watcher.PayloadTrackerWatcher"
    for watcher in config["service"]["watchers"]:
        if watcher["name"] == pt_watcher:
            watcher["kwargs"]["bootstrap_servers"] = kafka_url
    return config
