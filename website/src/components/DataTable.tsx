import { Box, Typography } from "@mui/material";
import { useMemo } from "react";

interface IProps {
  title: string;
  data: [string, number[]][];
}

function DataTable(props: IProps) {
  const data = useMemo(() => {
    return props.data.sort(
      (a, b) => b[1][b[1].length - 1] - a[1][a[1].length - 1]
    );
  }, [props.data]);

  return (
    <>
      <Box display="flex" justifyContent="space-between" px={2} py={1}>
        <Typography color="white">{props.title}</Typography>
        <Typography color="white">Last Power Output</Typography>
      </Box>
      {data.map((d, i) => (
        <Box
          key={i}
          display="flex"
          justifyContent="space-between"
          px={2}
          py={1}
          sx={{
            background: i % 2 === 1 ? "#253544" : "#2a3b4c",
          }}
        >
          <Typography color="white">{d[0]}</Typography>
          <Typography color="white">{d[1][d[1].length - 1]}</Typography>
        </Box>
      ))}
    </>
  );
}

export default DataTable;
