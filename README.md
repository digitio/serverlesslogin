# ServerLess Login and Manage Subscription

A basic standalone application made by chatGPT for serverless login without google or any backend 
service to handle subscription and in the screen where you can edit it as well as delete it 
according to your users data.

Here are some points to highlight the key features of your project:

### Key Features:
1. **Serverless Architecture**:
    - No dependency on external servers for login or data storage.
    - All data is stored locally on the user's device.

2. **Local Storage**:
    - Utilizes local storage mechanisms available on the device.
    - Ensures data persistence without needing a network connection.

3. **Security**:
    - Uses SHA encryption to securely handle and store sensitive data like passwords.
    - Protects user data from unauthorized access.

### Benefits:
- **Offline Accessibility**: Since the app doesn't rely on a server, it can function entirely offline.
- **Enhanced Security**: Local storage with SHA encryption ensures that user data is secure and not exposed to potential server-side vulnerabilities.
- **Ease of Use**: Users don't need to worry about server downtimes or connectivity issues affecting their ability to use the app.

### How to Get Started:
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/digitio/serverless-login-and-storage.git
   ```

2. **Install Dependencies**:
   ```bash
   cd serverless-login-and-storage
   flutter pub get
   ```

3. **Run the Application**:
   ```bash
   flutter run
   ```

### Future Enhancements:
- **Biometric Authentication**: Implementing fingerprint or facial recognition for added security.
- **Data Backup**: Allowing users to optionally back up their encrypted data to a cloud service.
- **Cross-Platform Sync**: Enabling data synchronization across multiple devices while maintaining the serverless approach.

If you have any specific questions or need further assistance with your project, feel free to ask!


### ChatGPT Link for complete link:
- https://chatgpt.com/share/e89d083f-c26c-4962-b14c-af108910800c (ChatGPT 4o)