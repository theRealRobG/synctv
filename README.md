# SyncStartTV

Shows how to synchronize playback of two live HLS streams. Forked from https://github.com/edwardmhunton/synctv.

## Overview

This sample requires that two live HLS streams be set up (although a single stream can be used twice for demonstration).
Each stream must contain `EXT-X-PROGRAM-DATE-TIME` tags; the dates must accurately reflect the authoring time of each
segment, and must be based on a common clock.

The stream is hard-coded within the `startNewPlayer` method in[ViewController](./SyncStartTV/ViewController.swift). It
currently uses just one public example stream from Unified which is useful as it contains a burnt in clock and audio
tones to validate if there is any dissonance between the two videos once started. It may be more interesting to use two
different streams, so long as they are synchronized at encode to the same clock.

## Getting Started

This sample requires tvOS 11 or greater, and Xcode 9 or greater. (It is also possible to run this code on iOS 11
instead, with minor modifications.)

The original example in the forked from repo configured the streams via a Bonjour service. This required that you
provide your own locally served streams. I've modified the example to use a hard-coded public example stream.

Each HLS live stream must contain `EXT-X-PROGRAM-DATE-TIME` tags. The dates must be based on a shared clock, and they
must be exact (i.e., to within a frame duration, using millisecond-level dates such as 2010-02-19T14:54:23.031Z). ~~A~~
~~single stream can be used instead of two streams; it just won't be as interesting~~ A single stream is used instead of
two streams; it isn't as interesting, but feel free to find your own example streams or use the forked from repo if you
can serve them locally.

Both videos start automatically *(there is no selection UX in this fork)*.

The basic approach to starting a second stream playing in sync with a first is:

1. Start the first stream playing (at rate 1.0).

2. Use the AVPlayerItem currentTime and currentDate properties of each stream to determine their relative time offset,
   relying on the fact that the dates are in sync.

3. Wait until the second player has enough buffered ahead of the current position of the first player to begin playback
   of the second player.

4. Once the second player has enough buffered, use the `AVPlayer` `setRate( time: atHostTime:)` method to set the rate
   on the second player to 1.0. To start it in sync with the first player, get the current time of the first player and
   the corresponding host time, then pass the corresponding time in the second player and the host time to the setRate
   call. See `tryToStartSecondPlayerInSync()` for more detail.
