import { User, signOut } from "firebase/auth";
import { auth } from "../firebase";
import Button from "@mui/material/Button";
import { UserData } from "../types";
import Box from "@mui/material/Box";
import Tabs from "@mui/material/Tabs";
import Tab from "@mui/material/Tab";
import { useState } from "react";

interface IProps {
  user: User;
  userData: UserData;
}

function UserHome(props: IProps) {
  const [value, setValue] = useState(0);
  const handleChange = (_: React.SyntheticEvent, newValue: number) => {
    setValue(newValue);
  };
  console.log(props);
  return (
    <>
      <Box sx={{ borderBottom: 1, borderColor: "divider" }}>
        <Tabs
          value={value}
          onChange={handleChange}
          aria-label="basic tabs example"
        >
          <Tab label="Leaderboard" />
          <Tab label="My Home" />
        </Tabs>
      </Box>
      {value === 0 ? (
        // LeaderBoard
        <p>Leaderboard</p>
      ) : (
        // My Home
        <p>my home</p>
      )}
      <Button
        variant="outlined"
        onClick={() => signOut(auth)}
        style={{ color: "white" }}
      >
        Sign out
      </Button>
    </>
  );
}

export default UserHome;
