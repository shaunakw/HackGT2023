import {
  User,
  onAuthStateChanged,
  signInWithRedirect,
  signOut,
} from "firebase/auth";
import { auth, githubProvider } from "./firebase";
import { useEffect, useState } from "react";
import Button from "@mui/material/Button";
import Box from "@mui/material/Box";
import React from 'react';
import Typewriter from "typewriter-effect";
import './App.css';

function App() {
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState<User | null>(null);

  useEffect(() => {
    onAuthStateChanged(auth, (user) => {
      setLoading(false);
      setUser(user);
      console.log(user);
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
    <div className="type" style={{width:"50%"}}>
      <Typewriter
          onInit={(typewriter) => {
            typewriter
              .typeString("Welcome to Watt Wizard! Compete with your friends and save the most energy!")
              .start();
          }}
      />
    </div>
      {!loading ? (
        <Box display="flex" flexDirection="row" gap={2}>
          {!user && (
          <>
            <Button style={{color:"lightgrey"}} variant="outlined" onClick= {() => window.open('https://www.youtube.com/watch?v=dQw4w9WgXcQ', '_blank')}>
              Leaderboard
            </Button>
            <Button style={{color:"lightgrey"}} variant="outlined" onClick= {() => window.open('https://www.youtube.com/watch?v=dQw4w9WgXcQ', '_blank')}>
              Find out More
            </Button>
            <Button
              variant="outlined"
              style={{color:"lightgrey"}}
              onClick={() => signInWithRedirect(auth, githubProvider)}
            >
              Sign in
            </Button>
          </>
          )}
          {user && (
            <Button variant="outlined" onClick={() => signOut(auth)} style={{color:"white"}}>
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
