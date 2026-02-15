import Carbon

func enableInputSource(id: String) {
    let properties: [String: Any] = [
        kTISPropertyInputSourceID as String: id
    ]
    guard let list = TISCreateInputSourceList(properties as CFDictionary, true)?
        .takeRetainedValue() as? [TISInputSource],
          let source = list.first else {
        fputs("Input source not found: \(id)\n", stderr)
        exit(1)
    }
    let err = TISEnableInputSource(source)
    if err != noErr {
        fputs("TISEnableInputSource failed: OSStatus \(err)\n", stderr)
        exit(1)
    }
    print("Enabled: \(id)")
}

let args = CommandLine.arguments
guard args.count > 1 else {
    fputs("Usage: enable-input-source <input-source-id>\n", stderr)
    exit(1)
}
enableInputSource(id: args[1])
