import { User, onAuthStateChanged, signInWithRedirect } from "firebase/auth";
import { auth, getUserData, githubProvider } from "./firebase";
import { useEffect, useState } from "react";
import Button from "@mui/material/Button";
import Box from "@mui/material/Box";
import Typewriter from "typewriter-effect";
import { UserData } from "./types";
import UserHome from "./components/UserHome";
import "./App.css";
import { CircularProgress, Typography } from "@mui/material";

function App() {
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState<User | null>(null);
  const [userData, setUserData] = useState<UserData>();

  const [titleDone, setTitleDone] = useState(false);

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
        background: "#2c3e50",
        position: "relative",
        overflow: "hidden",
      }}
    >
      {!loading ? (
        user ? (
          <UserHome user={user} userData={userData!} />
        ) : (
          <>
            <Box
              display="flex"
              position="absolute"
              top={0}
              right={0}
              px={4}
              py={2}
            >
              <Button
                style={{ color: "white" }}
                onClick={() => signInWithRedirect(auth, githubProvider)}
              >
                Sign In
              </Button>
            </Box>
            <div
              className="type"
              style={{
                fontFamily: "Roboto",
                fontWeight: 400,
              }}
            >
              <Typewriter
                options={{
                  delay: 75,
                }}
                onInit={(typewriter) => {
                  typewriter
                    .typeString("Welcome to Watt Wizard!")
                    .pauseFor(100)
                    .callFunction(() => setTitleDone(true))
                    .start();
                }}
              />
            </div>
            <Typography
              variant="h5"
              color={titleDone ? "white" : "transparent"}
              mb={4}
              className="subtitle"
            >
              Compete with your friends to save the most energy!
            </Typography>
            <Button
              style={{ color: "lightgrey" }}
              variant="outlined"
              onClick={() =>
                window.open(
                  "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
                  "_blank"
                )
              }
            >
              Find out More
            </Button>
          </>
        )
      ) : (
        <CircularProgress style={{ color: "white" }} />
      )}
    </Box>
  );
}

export default App;
