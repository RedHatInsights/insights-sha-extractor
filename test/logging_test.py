# Copyright 2022 Red Hat, Inc
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

"""Module containing unit tests for the `logging.py` file."""
import re
import logging

from insights_sha_extractor.logging import get_mac_address, CloudWatchFormatter

MAC_ADDRESS_REGEX = r"^([0-9A-Fa-f]{1,2}[:-]){5}([0-9A-Fa-f]{1,2})$"


def test_get_mac_address():
    """Verify the `get_mac_address` function works."""
    mac_address = get_mac_address()
    assert re.match(MAC_ADDRESS_REGEX, mac_address), f"{mac_address} is not a valid MAC address"


def test_CloudWatchFormatter_init():
    """Verify the `CloudWatchFormatter` is initialized with a valid hostname and MAC address."""
    cwf = CloudWatchFormatter()
    assert cwf.hostname != ""
    assert re.match(MAC_ADDRESS_REGEX, cwf.mac_address)


def test_CloudWatchFormatter_format():
    """Verify the `CloudWatchFormatter` formats the log record with its hostname and MAC address."""
    record = logging.LogRecord(
        name=None, level=0, pathname="", lineno=0, msg="test", args=(), exc_info=None
    )
    cwf = CloudWatchFormatter()
    cwf.format(record)
    assert record.mac_address == cwf.mac_address
    assert record.hostname == cwf.hostname
