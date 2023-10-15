import { signOut } from "firebase/auth";
import { Box, Button, Card, Grid, Typography } from "@mui/material";
import { auth } from "../firebase";
import { UserData } from "../types";
import Devices from "./Devices";
import MyHome from "./MyHome";
import Leaderboard from "./Leaderboard";

interface IProps {
  userData: UserData;
}

function UserHome(props: IProps) {
  return (
    <Box display="flex" flexDirection="column" width="100vw" height="100vh">
      <Box display="flex" alignItems="center">
        <img
          src="/favicon.png"
          alt="logo"
          width={44}
          height={44}
          style={{ paddingLeft: 16 }}
        />
        <Typography pl={2} variant="h4" color="white" fontFamily="Young Serif">
          Watt Wizard
        </Typography>
        <Box flex={1} />
        <Box px={4} py={2}>
          <Button
            variant="outlined"
            style={{ color: "white", border: "1px solid white" }}
            onClick={() => signOut(auth)}
          >
            Sign Out
          </Button>
        </Box>
      </Box>
      <Grid container flex={1} px={1.5} pb={1.5}>
        <Grid item p={1.5} xs={4}>
          <Card
            elevation={8}
            style={{
              height: "100%",
              backgroundColor: "whitesmoke",
              borderRadius: 10,
            }}
          >
            <Leaderboard />
          </Card>
        </Grid>
        <Grid item p={1.5} xs={4}>
          <Card
            elevation={8}
            style={{
              height: "100%",
              backgroundColor: "whitesmoke",
              borderRadius: 10,
            }}
          >
            <MyHome {...props} />
          </Card>
        </Grid>
        <Grid item p={1.5} xs={4}>
          <Card
            elevation={8}
            style={{
              height: "100%",
              backgroundColor: "whitesmoke",
              borderRadius: 10,
            }}
          >
            <Devices {...props} />
          </Card>
        </Grid>
      </Grid>
    </Box>
  );
}

export default UserHome;
