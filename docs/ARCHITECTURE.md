# Push-to-Talk MVP Architecture

## High-level Flow

```
+----------------+       +------------------+       +------------------+       +-------------------+
|   PttButton    |  -->  |  App Services    |  -->  |   Transmission   |  -->  | Remote Reception  |
|  (UI Widget)   |       | (PTT & Push FCM) |       |   (Future WebRTC)|       |  & Auto Playback  |
+----------------+       +------------------+       +------------------+       +-------------------+
        ^                                                                                          |
        |                                                                                          |
        +------------------------------------------------------------------------------------------+
                                      (Opt-in Auto Playback)
```

1. Users press and hold the `PttButton` widget in the Flutter UI.
2. The button delegates to the `PttService`, which will coordinate microphone capture and audio buffering.
3. Captured audio is prepared for transmission. The MVP uses stubs that will later be backed by WebRTC transport.
4. On the receiving device, incoming audio is automatically played back only for contacts that the user has whitelisted.

## Policy Notes

- Automatic playback is strictly opt-in. Users control which contacts or channels are allowed to play audio without manual interaction.
- Background push notifications via FCM will be used to wake the service when new messages arrive. The current implementation includes TODOs where the production logic will live.
