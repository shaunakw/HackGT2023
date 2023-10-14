export interface UserData {
  friends?: string[];
  household?: string;
  pfp?: string;
  devices?: Device[];
}

export interface Device {
  name: string;
  power: number[];
}
