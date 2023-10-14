import { initializeApp } from "firebase/app";

const firebaseConfig = {
  apiKey: "AIzaSyAEZWnInWLWU5yqG7Y1NyKkQSon_RRxWNY",
  authDomain: "hackgt2023.firebaseapp.com",
  projectId: "hackgt2023",
  storageBucket: "hackgt2023.appspot.com",
  messagingSenderId: "192909855910",
  appId: "1:192909855910:web:f50aa440ac666be3873867",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

export async function init() {
  console.log(app);
}
