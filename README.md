# Dexcom HeartChecker & Glucose WatchOS App

## Description

The Dexcom WatchOS App is designed to provide real-time glucose and heart rate monitoring for Dexcom users directly on their Apple Watch. The app utilizes Dexcom's APIs to fetch this vital data.

## Table of Contents

- [Features](#features)
- [Future Features](#future-features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Caveats](#caveats)
- [Contributing](#contributing)
- [License](#license)

## Features

- Real-time glucose levels
- Real-time heart rate monitoring
- Elegant and user-friendly UI
- Data synchronization

## Future Features

1. Predicting anxiety levels via measuring glucose and heart rate patterns

## Prerequisites

- watchOS 7.0+
- Xcode 12.0+
- Swift 5.0+
- Dexcom API credentials

## Installation

1. **Clone the repository.**
    ```sh
    git clone https://github.com/maxfritzhand/dexcomheartchecker.git
    ```

2. **Navigate into the project folder.**
    ```sh
    cd HeartChecker
    ```

3. **Open the project in Xcode.**
    ```sh
    open HeartChecker.xcodeproj
    ```

4. **Insert your Dexcom API credentials in `DexcomAPI.swift`.**

## Usage

### Using Sample Dexcom API

The app is configured to use a sample Dexcom API by default. Register on Dexcom to get an API token and reference the appropriate values into dexcomtoken. Call dexcomserver and from there call dexcomtoken. To switch to your registered Dexcom API, follow the instructions in the Installation section.

### Running the App

After setting up your Dexcom API credentials, simply build and run the app in Xcode.

## Caveats

1. The app currently uses a sample Dexcom API. To use your own registered Dexcom API, switch the API details in `APIManager.swift`.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License.
