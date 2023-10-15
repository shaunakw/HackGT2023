import { CircularProgress, Typography } from "@mui/material";
import { useCallback, useEffect, useState } from "react";
import { getAllHomes, getMultipleUserData } from "../firebase";
import DataTable from "./DataTable";

function Leaderboard() {
  const [loading, setLoading] = useState(true);
  const [data, setData] = useState<[string, number[]][]>([]);

  const loadData = useCallback(async () => {
    setLoading(true);
    const homes = await getAllHomes();
    const data: [string, number[]][] = [];
    for (const home of homes) {
      if (home.users && home.users.length > 0) {
        const array = await getMultipleUserData(home.users);
        console.log(array);
        const dataArray = array
          .filter(
            (data) => data.devices?.length && data.devices[0].power?.length
          )
          .map((data) =>
            data.devices!.reduce(
              (power, device) => power.map((p, i) => p + device.power![i]),
              data.devices![0].power!.map(() => 0)
            )
          );
        const sumArray = dataArray.reduce((power, user) =>
          power.map((p, i) => p + user[i])
        );
        data.push([home.name, sumArray]);
      }
    }
    setData(data);
    setLoading(false);
  }, []);

  useEffect(() => {
    loadData();
  }, [loadData]);

  return !loading ? (
    <>
      <Typography variant="h5" color="white" p={2}>
        Leaderboard
      </Typography>
      <DataTable title="Home" data={data} />
    </>
  ) : (
    <CircularProgress />
  );
}

export default Leaderboard;
