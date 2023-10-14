import {
  User,
  onAuthStateChanged,
  signInWithRedirect,
  signOut,
} from "firebase/auth";
import { auth, getUserData, githubProvider } from "./firebase";
import { useEffect, useState } from "react";
import Button from "@mui/material/Button";
import Box from "@mui/material/Box";
import { UserData } from "./types";

function App() {
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState<User | null>(null);
  const [userData, setUserData] = useState<UserData>();

  useEffect(() => {
    onAuthStateChanged(auth, async (user) => {
      if (user) {
        setUserData(await getUserData(user));
      } else {
        setUserData(undefined);
      }

      setUser(user);
      setLoading(false);
    });
  }, []);

  return (
    <Box
      display="flex"
      justifyContent="center"
      alignItems="center"
      minHeight="100vh"
      flexDirection="column"
      gap={2}
      sx={{
        background: "linear-gradient(45deg, #09203F 30%, #537895 90%)",
        position: "relative",
        overflow: "hidden",
      }}
    >
      {!loading ? (
        <Box display="flex" flexDirection="row" gap={2}>
          {!user && (
            <Button
              variant="outlined"
              onClick={() => signInWithRedirect(auth, githubProvider)}
            >
              Sign in
            </Button>
          )}
          {user && (
            <Button variant="outlined" onClick={() => signOut(auth)}>
              Sign out
            </Button>
          )}
        </Box>
      ) : (
        <p>loading</p>
      )}
    </Box>
  );
}

export default App;
