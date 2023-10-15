export interface UserData {
  friends?: string[];
  home?: string;
  pfp: string;
  name: string;
  devices?: Device[];
}

export interface Device {
  name: string;
  power?: number[];
}

export interface Home {
  name: string;
  pfp: string;
  users?: string[];
}
