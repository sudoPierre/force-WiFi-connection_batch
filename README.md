# WiFi Profile Configuration Script

This script creates a WiFi profile in XML format and injects it into the machine settings using `netsh wlan` commands.

## Features
- Automatically generates a WiFi profile XML file.
- Temporarily stores the profile in a user-specific directory.
- Imports the WiFi profile into the system.
- Attempts to connect to the specified WiFi network.
- Deletes temporary files after execution.

## Prerequisites
- Windows operating system.
- Administrator privileges.

## Installation
1. Clone this repository or download the `wifi_setup.bat` script.
2. Modify the script to replace:
   - `access point` with your WiFi SSID.
   - `password` with your WiFi password.
3. Save the script.

## Usage
1. Open Command Prompt as Administrator.
2. Navigate to the script directory.
3. Run the script:
   ```sh
   wifi_setup.bat
   ```
4. The script will:
   - Check if the system is already connected to the specified WiFi.
   - Create an XML profile and attempt a connection.
   - Notify if the connection is successful or failed.

## Troubleshooting
- If the connection fails, ensure:
  - The SSID and password are correctly set in the script.
  - The WiFi network is available and in range.
  - The system has necessary permissions to modify network settings.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author
sudoPierre

