import { Typography } from "@mui/material";
import { UserData } from "../types";
import { useMemo } from "react";
import DataTable from "./DataTable";

interface IProps {
  userData: UserData;
}

function Devices(props: IProps) {
  const data = useMemo(() => {
    const devices = props.userData.devices ?? [];
    return devices.map(
      (device) => [device.name, device.power] as [string, number[]]
    );
  }, [props.userData.devices]);

  return (
    <>
      <Typography variant="h5" p={2}>
        My Devices
      </Typography>
      <DataTable title="Device Name" data={data} />
    </>
  );
}

export default Devices;
