# Copyright 2021, 2022 Red Hat, Inc
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

"""Module containing unit tests for the `Consumer` class."""
import sys
import pytest
import logging
from unittest.mock import MagicMock, patch

import insights_sha_extractor.command_line as command_line


def test_command_line_args_valid_flag_version():
    """Verify correct parsing of --version flag."""
    sys.argv = ["insights-sha-extractor", "--version"]
    parser = command_line.parse_args()
    assert not parser.config
    assert parser.version


def test_command_line_args_valid_config_value():
    """Verify correct parsing of positional argument <config>."""
    sys.argv = ["insights-sha-extractor", "path_to_config_file"]
    parser = command_line.parse_args()
    assert not parser.version
    assert parser.config


def test_command_line_print_version(caplog):
    """Verify the version is printed."""
    with caplog.at_level(logging.INFO):
        command_line.print_version()
    assert "insights-sha-extractor version" in caplog.text


def test_command_line_apply_config_no_file(caplog):
    """Verify the apply_config fails if the file doesn't exist."""
    try:
        command_line.apply_config("test.yaml")
        assert False
    except FileNotFoundError:
        assert True


@patch("ccx_messaging.consumers.kafka_consumer.ConfluentConsumer")
def test_command_line_apply_config_valid_file(consumer_init_mock, caplog):
    """Verify the configuration is applied if a valid file is given."""
    consumer_mock = MagicMock()
    consumer_init_mock.return_value = consumer_mock

    consumer_mock.consume.side_effect = [KeyboardInterrupt]
    command_line.apply_config(
        "config.yaml"
    )  # this should finish due to receiving a KeyboardInterrupt


def test_command_line_args_no_config_provided():
    """Verify app does not start if no config provided and exit with code 1."""
    with pytest.raises(SystemExit) as exception:
        sys.argv = ["insights-sha-extractor"]
        command_line.insights_sha_extractor()
    assert exception.type == SystemExit
    assert exception.value.code == 1


def test_command_line_args_invalid_arg_provided(capsys):
    """Verify help is shown if invalid argument provided."""
    sys.argv = ["insights-sha-extractor", "--config"]
    with pytest.raises(SystemExit) as exception:
        parser = command_line.parse_args()

        assert exception.type == SystemExit
        assert exception.value.code == 2

        assert not parser.config
        assert not parser.version

        captured = capsys.readouterr()
        assert "usage: insights-sha-extractor" in captured.out
        assert "error: unrecognized arguments" in captured.out
