import { UserData } from "../types";
import { useEffect } from "react";

interface IProps {
  userData: UserData;
}

function Devices(props: IProps) {
  // const [loading, setLoading] = useState(true);
  console.log(props);

  useEffect(() => {
    // getDevices(props.user.uid);
  }, []);

  return <p></p>;
}

export default Devices;
