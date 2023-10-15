import { CircularProgress, Typography } from "@mui/material";
import { UserData } from "../types";
import { useCallback, useEffect, useState } from "react";
import { getHome, getMultipleUserData } from "../firebase";
import DataTable from "./DataTable";

interface IProps {
  userData: UserData;
}

function MyHome(props: IProps) {
  const [loading, setLoading] = useState(true);
  const [name, setName] = useState("");
  const [data, setData] = useState<[string, number[]][]>([]);

  const loadData = useCallback(async () => {
    if (props.userData.home) {
      setLoading(true);
      const home = await getHome(props.userData.home);
      const userDatas = await getMultipleUserData(home.users ?? []);
      const data = userDatas
        .filter(
          (userData) =>
            userData.devices?.length && userData.devices[0].power?.length
        )
        .map((userData) => {
          const power = userData.devices!.reduce(
            (power, device) => power.map((p, i) => p + device.power![i]),
            userData.devices![0].power!.map(() => 0)
          );
          return [userData.name, power] as [string, number[]];
        });
      setName(home.name);
      setData(data);
      setLoading(false);
    }
  }, [props.userData.home]);

  useEffect(() => {
    loadData();
  }, [loadData]);

  return props.userData.home ? (
    !loading ? (
      <>
        <Typography variant="h5" p={2}>
          {name}
        </Typography>
        <DataTable title="Name" data={data} />
      </>
    ) : (
      <CircularProgress />
    )
  ) : (
    <>
      <Typography variant="h5" p={2}>
        No Home
      </Typography>
      <Typography px={2} py={1}>
        Join a home to see how you stack up against your housemates!
      </Typography>
    </>
  );
}

export default MyHome;
