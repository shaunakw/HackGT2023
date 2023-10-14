import { initializeApp } from "firebase/app";
import { GithubAuthProvider, getAuth } from "firebase/auth";
import { doc, getDoc, getFirestore, setDoc } from "firebase/firestore";
import { UserData } from "./types";

const firebaseConfig = {
  apiKey: "AIzaSyAEZWnInWLWU5yqG7Y1NyKkQSon_RRxWNY",
  authDomain: "hackgt2023.firebaseapp.com",
  projectId: "hackgt2023",
  storageBucket: "hackgt2023.appspot.com",
  messagingSenderId: "192909855910",
  appId: "1:192909855910:web:f50aa440ac666be3873867",
};

export const githubProvider = new GithubAuthProvider();
githubProvider.addScope("user:email");

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const db = getFirestore(app);

export async function getUserData(uid: string) {
  const docRef = doc(db, "users", uid);
  const docSnap = await getDoc(docRef);
  if (!docSnap.exists()) {
    await setDoc(docRef, {});
    return {};
  }

  return docSnap.data() as UserData;
}
