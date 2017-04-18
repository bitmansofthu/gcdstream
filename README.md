# GCDStream
GCD based wrapper for NSInputStream and NSOutputStream written in Objective-C.

## Usage

```
NSInputStream* inStream = ...
NSOutputStream* outStream = ...

GCDStream* gcdStream = [GCDStream gcdStreamWithInputStream: inStream outputStream: outStream];
gcdStream.delegate = self;
[gcdStream open];

```
