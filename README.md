# GCDStream
GCD based wrapper for NSInputStream and NSOutputStream written in Objective-C.
The NSStreamDelegate for the provided NSStreams are scheduled on the main runloop, however read/write actions are handled on separate *GCD queues*.

Typically useful for socket and [External Accessory](https://developer.apple.com/reference/externalaccessory/eaaccessory) communications.

## Usage

```
NSInputStream* inStream = ...
NSOutputStream* outStream = ...

GCDStream* gcdStream = [GCDStream gcdStreamWithInputStream: inStream outputStream: outStream];
gcdStream.delegate = self;
[gcdStream open];

```
### Delegate calls

```
- (void)gcdStream:(GCDStream *)gcdstream didOpenStream:(NSStream *)stream {
    // stream opened
}

- (void)gcdStream:(GCDStream *)gcdstream didReceiveData:(NSData *)data {
    // data received in InputStream
}

- (void)gcdStream:(GCDStream *)gcdstream errorOccured:(NSError *)error withStream:(NSStream *)stream {
    // an error occured with the stream
}

- (void)gcdStream:(GCDStream *)gcdstream streamEndEncountered:(NSStream *)stream {
    // end of stream encountered
}
```
