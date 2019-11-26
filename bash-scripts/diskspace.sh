#!/bin/bash
df | grep nvme0n1p2 | awk '{print $5}'
