import { User, onAuthStateChanged, signInWithRedirect } from "firebase/auth";
import { useEffect, useState } from "react";
import { Box, Button, CircularProgress, Typography } from "@mui/material";
import Typewriter from "typewriter-effect";
import UserHome from "./components/UserHome";
import Dots from "./components/Dots";
import { auth, getCurrentUserData, githubProvider } from "./firebase";
import { UserData } from "./types";
import "./App.css";

function App() {
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState<User | null>(null);
  const [userData, setUserData] = useState<UserData>();

  const [titleDone, setTitleDone] = useState(false);

  useEffect(() => {
    onAuthStateChanged(auth, async (user) => {
      if (user) {
        setUserData(await getCurrentUserData(user));
      } else {
        setUserData(undefined);
      }

      setUser(user);
      setLoading(false);
    });
  }, []);

  return (
    <>
      {!loading && !user && <Dots />}
      <Box
        display="flex"
        justifyContent="center"
        alignItems="center"
        minHeight="100vh"
        flexDirection="column"
        gap={2}
        sx={{
          background: loading || user ? "#0abde3" : undefined, // 191
          position: "relative",
          overflow: "hidden",
        }}
      >
        {!loading ? (
          user ? (
            <UserHome userData={userData!} />
          ) : (
            <>
              <Box
                display="flex"
                justifyContent="space-between"
                alignItems="start"
                position="absolute"
                top={0}
                left={0}
                width="100%"
                boxSizing="border-box"
                p={2}
              >
                <img src="/favicon.png" alt="logo" width={44} height={44} />
                <Button
                  variant="outlined"
                  style={{
                    color: "white",
                    border: "1px solid white",
                    marginRight: 16,
                  }}
                  onClick={() => signInWithRedirect(auth, githubProvider)}
                >
                  Sign In
                </Button>
              </Box>
              <div
                className="type"
                style={{
                  fontFamily: "Young Serif",
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
                style={{ color: "white", border: "1px solid white" }}
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
    </>
  );
}

export default App;
