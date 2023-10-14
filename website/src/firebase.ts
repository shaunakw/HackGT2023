import { initializeApp } from "firebase/app";
import { GithubAuthProvider, User, getAuth } from "firebase/auth";
import {
  collection,
  doc,
  documentId,
  getDoc,
  getDocs,
  getFirestore,
  query,
  setDoc,
  where,
} from "firebase/firestore";
import { Home, UserData } from "./types";

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

export async function getMultipleUserData(uids: string[]): Promise<UserData[]> {
  const q = query(collection(db, "users"), where(documentId(), "in", uids));
  const querySnap = await getDocs(q);
  return querySnap.docs.map((doc) => doc.data() as UserData);
}

export async function getCurrentUserData(user: User): Promise<UserData> {
  const docRef = doc(db, "users", user.uid);
  const docSnap = await getDoc(docRef);
  if (!docSnap.exists()) {
    await setDoc(docRef, {});
    return { name: user.displayName ?? undefined };
  }

  return docSnap.data() as UserData;
}

export async function getAllHomes(): Promise<Home[]> {
  const querySnap = await getDocs(collection(db, "homes"));
  return querySnap.docs.map((doc) => doc.data() as Home);
}

export async function getHome(id: string): Promise<Home> {
  const docRef = doc(db, "homes", id);
  const docSnap = await getDoc(docRef);
  return docSnap.data() as Home;
}
