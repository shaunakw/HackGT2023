import { Box, Typography } from "@mui/material";
import { useMemo } from "react";
import DataTableEntry from "./DataTableEntry";

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
        <Typography color="white">Power Consumption (W)</Typography>
      </Box>
      {data.map((d, i) => (
        <DataTableEntry
          key={i}
          name={d[0]}
          values={d[1]}
          color={i % 2 === 1 ? "#253544" : "#2a3b4c"}
        />
      ))}
    </>
  );
}

export default DataTable;
