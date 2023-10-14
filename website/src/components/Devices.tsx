import { Box, Typography } from "@mui/material";
import { UserData } from "../types";
import { useMemo } from "react";

interface IProps {
  userData: UserData;
}

function Devices(props: IProps) {
  const devices = useMemo(() => {
    const unsorted = props.userData.devices ?? [];
    return unsorted.sort((a, b) => b.power[0] - a.power[0]);
  }, [props.userData.devices]);

  return (
    <>
      <Typography variant="h5" color="white" p={2}>
        My Devices
      </Typography>
      <Box display="flex" justifyContent="space-between" px={2} py={1}>
        <Typography color="white">Device Name</Typography>
        <Typography color="white">Last Power Output</Typography>
      </Box>
      {devices.map((device, i) => (
        <Box
          key={device.name}
          display="flex"
          justifyContent="space-between"
          px={2}
          py={1}
          sx={{
            background: i % 2 === 1 ? "#253544" : "#2a3b4c",
          }}
        >
          <Typography color="white">{device.name}</Typography>
          <Typography color="white">{device.power[0]}</Typography>
        </Box>
      ))}
    </>
  );
}

export default Devices;
