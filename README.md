# WATT WIZARD

Watt-Wizards is your go-to platform for sustainable living made fun and rewarding. This innovative app hooks into your smart home or breaker panel to track your energy and water usage in real-time. But that's not all! Challenge your friends in friendly competitions to see who can be the most resource-efficient. Earn points, unlock rewards, and level up your eco-conscious lifestyle, all while reducing your carbon footprint. Watt-Wizards turns everyday sustainability into an engaging game, making it easier than ever to save the planet—and your wallet."

## What it does
Watt Wizard promotes energy conservation by making it a competitive yet friendly challenge. Users can pit their energy-saving skills against friends and family, vying for the top spot in energy efficiency. By gamifying the process, it taps into the same motivational drive that has made group fitness 25% more effective than individual workouts. Just as people push themselves harder in a group exercise setting, they're also more likely to take energy-saving actions when they know they're in a friendly competition.

## How We Built It

### Website:
Our website serves as the main portal for users to get acquainted with our app's features, benefits, and the journey of getting started. We chose **React** for the frontend development due to its component-based architecture, which allows for efficient code reuse and dynamic user interfaces. It aids in delivering a smooth and responsive experience for our users. The site's backend is powered by **Firebase**, offering us a scalable cloud solution that seamlessly integrates with our web and mobile platforms. Firebase's real-time database and authentication modules ensured that we have a secure and live-updated platform. Furthermore, the site was styled and structured using **HTML**, **TypeScript**, and various frontend libraries, accounting for the mentioned percentages in our codebase.

### Mobile App:
The mobile app, the core of our user experience, was built using **Flutter**. Written in **Dart**, Flutter allowed us to create a cross-platform application that maintains a native feel on both Android and iOS devices. The app provides real-time tracking of energy savings, competitive leaderboards, and user rankings. We prioritized user-friendliness in our design, ensuring that users of all technical backgrounds could easily navigate and benefit from our app. Integration with Firebase ensures that user data is consistently synchronized, authenticated, and securely stored.

### Arduino Firmware:
For the hardware component, we leveraged **Arduino**, programming our devices using a combination of **C++** and the Arduino scripting language. This firmware emulates a smart home device, collecting real-time energy consumption data. Given the nature of IoT devices and the need for efficient performance, our choice of C++ enabled us to manage memory usage directly and ensure swift data processing. The firmware is designed to communicate seamlessly with our mobile application, transmitting real-time energy consumption data for users to monitor and act upon.

### Languages Utilized:
Our diverse tech stack incorporated various programming languages to meet specific needs:
- **Dart (31.8%)**: Primarily used for developing our Flutter mobile application.
- **C++ (25.5%)**: Used for Arduino firmware development to capture and process energy data.
- **CMake (17.4%)**: Assisted in managing the build process of our software using a compiler-independent method.
- **TypeScript (15.9%)**: Enhanced our React website development with static typing.
- **Ruby (2.6%)**: Possibly used in scripting, automation, or specific backend tasks.
- **HTML (2.4%)**: Structured our React website.
- **Other (4.4%)**: This likely includes various scripting, configuration, and styling languages that aided in the development and deployment processes.

Our diverse choice of languages and technologies ensured that each component of our project was optimized for performance, scalability, and user experience.

## Challenges I ran into
- **Integration across platforms**: Ensuring seamless communication between the Arduino device, mobile app, and website was challenging, especially when it came to real-time data transfer.
- **User Experience Design**: Designing an interface that was both engaging and user-friendly required multiple iterations and feedback sessions.
- **Data Accuracy**: Ensuring the Arduino device accurately captured and transmitted energy consumption data was crucial for the app's credibility and effectiveness.

## Accomplishments that I'm proud of
- **Real-time Tracking**: Achieving real-time energy consumption tracking, which provides users with immediate feedback on their energy-saving actions.
- **Gamification**: Successfully translating the concept of energy saving into a competitive and fun game, making conservation more appealing to a broader audience.
- **Cross-platform Integration**: Seamlessly integrating data across the website, app, and Arduino device.

## What I learned
- The importance of user feedback in refining the app experience.
- The technical intricacies of integrating hardware (Arduino) with software platforms.
- The power of gamification in driving behavior change.

## What's next for Watt Wizard
- **Integration with more Smart Devices**: Expanding compatibility to include other smart home devices, allowing users to track a broader range of energy consumption.
- **Rewards System**: Introducing tangible rewards for top savers, such as discounts on energy bills or eco-friendly products.
- **Community Features**: Adding features like forums or chat rooms where users can share energy-saving tips and strategies with one another.
