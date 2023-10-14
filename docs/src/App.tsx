import { signInWithRedirect, signOut } from "firebase/auth";
import { auth, githubProvider } from "./firebase";

function App() {
  return (
    <div>
      <p>Hello</p>
      <button onClick={() => signInWithRedirect(auth, githubProvider)}>
        Sign in
      </button>
      <button onClick={() => signOut(auth)}>Sign out</button>
    </div>
  );
}

export default App;
