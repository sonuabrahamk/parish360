export interface Permissions {
  data: {
    [key: string]: string[];
  };
  screen: {
    [key: string]: string[];
  };
}
export interface FooterEvent {
  isEditMode: boolean;
  isSaveTriggered: boolean;
  isCancelTriggered: boolean;
}
