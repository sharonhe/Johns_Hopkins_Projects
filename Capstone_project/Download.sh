#!/bin/bash

fastq-dump -v --gzip SRR1554534

/usr/bin/osascript -e 'tell application "Messages"
send "SRR1554534 Downloaded yo" to buddy "sshe1986@gmail.com" of service "E:sshe1986@gmail.com"
end tell'
echo "Sent"

fastq-dump -v --gzip SRR2071345

/usr/bin/osascript -e 'tell application "Messages"
send "SRR2071345 Downloaded yo" to buddy "sshe1986@gmail.com" of service "E:msshe1986@gmail.com"
end tell'
echo "Sent"

fastq-dump -v --gzip SRR1554539

/usr/bin/osascript -e 'tell application "Messages"
send "SRR1554539 Downloaded yo" to buddy "sshe1986@gmail.com" of service "E:sshe1986@gmail.com"
end tell'
echo "Sent"

fastq-dump -v --gzip SRR2071350

/usr/bin/osascript -e 'tell application "Messages"
send "SRR2071350 Downloaded yo" to buddy "sshe1986@gmail.com" of service "E:sshe1986@gmail.com"
end tell'
echo "Sent"

