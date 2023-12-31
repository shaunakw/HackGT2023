import { Box, Card, IconButton, Modal, Typography } from "@mui/material";
import CloseIcon from "@mui/icons-material/Close";
import { LineChart } from "@mui/x-charts";
import { useState } from "react";

interface IProps {
  color?: string;
  name: string;
  values: number[];
}

function DataTableEntry(props: IProps) {
  const [open, setOpen] = useState(false);

  console.log(open);

  return (
    <>
      <Box
        display="flex"
        justifyContent="space-between"
        px={2}
        py={1}
        sx={{
          background: props.color,
          cursor: "pointer",
        }}
        onClick={() => setOpen(true)}
      >
        <Typography>{props.name}</Typography>
        <Typography>{props.values[props.values.length - 1]}</Typography>
      </Box>
      <Modal open={open} onClose={() => setOpen(false)}>
        <Card
          elevation={8}
          style={{
            position: "absolute",
            top: "50%",
            left: "50%",
            transform: "translate(-50%,-50%)",
            backgroundColor: "whitesmoke",
            borderRadius: 10,
            width: 600,
            padding: 16,
          }}
        >
          <Box
            display="flex"
            justifyContent="space-between"
            alignItems="center"
          >
            <Typography variant="h5">{props.name}</Typography>
            <IconButton onClick={() => setOpen(false)}>
              <CloseIcon />
            </IconButton>
          </Box>
          <LineChart
            xAxis={[{ data: props.values.map((_, i) => i) }]}
            series={[{ data: props.values }]}
            width={600 - 2 * 16}
            height={400}
          />
        </Card>
      </Modal>
    </>
  );
}

export default DataTableEntry;
