unit DarkModeApi.Messages;

interface

uses
  Winapi.Messages, DarkModeApi.Consts;

type
  TEmptyMessage = record end; // remove when messages is declared properly

//  TWMNotify = record
//    Msg: Cardinal;
//    MsgFiller: TDWordFiller;
//    IDCtrl: WPARAM;
//    NMHdr: PNMHdr;
//    Result: LRESULT;
//  end;
//
//  TWMMeasureItem = record
//    Msg: Cardinal;
//    MsgFiller: TDWordFiller;
//    IDCtl: HWnd;
//    MeasureItemStruct: PMeasureItemStruct;
//    Result: LRESULT;
//  end;

const

  WM_UAHDESTROYWINDOW    = DarkModeApi.Consts.WM_UAHDESTROYWINDOW;	// handled by DefWindowProc
  WM_UAHDRAWMENU         = DarkModeApi.Consts.WM_UAHDRAWMENU;	        // lParam is UAHMENU
  WM_UAHDRAWMENUITEM     = DarkModeApi.Consts.WM_UAHDRAWMENUITEM;	// lParam is UAHDRAWMENUITEM
  WM_UAHINITMENU         = DarkModeApi.Consts.WM_UAHINITMENU;	        // handled by DefWindowProc
  WM_UAHMEASUREMENUITEM  = DarkModeApi.Consts.WM_UAHMEASUREMENUITEM;	// lParam is UAHMEASUREMENUITEM
  WM_UAHNCPAINTMENUPOPUP = DarkModeApi.Consts.WM_UAHNCPAINTMENUPOPUP;	// handled by DefWindowProc
  WM_UAHUPDATE           = DarkModeApi.Consts.WM_UAHUPDATE;

implementation

end.
