{R08}

unit constants;



interface

const BIT_ALWAYS_ARMED                     =1;
const BIT_RESET_ALARM_AFTER_DISARMED       =2;
const BIT_RESET_ALARM_AFTER_READY          =4;
const BIT_OFF                              =8;
const BIT_LOOP                             =16;

const BIT_READY       =1;
const BIT_ARMED       =2;
const BIT_ALARM       =4;
const BIT_BYPASS      =8;
const BIT_ENABLE      =$80;

const TYPEDEVICE_UNKNOW        = 0;
const TYPEDEVICE_RIC           = 1;
const TYPEDEVICE_VRIC          = 3;
const TYPEDEVICE_KBD           = 2;
const TYPEDEVICE_SIGRIC        = 4;
const TYPEDEVICE_TRANE         = 5;

const         TYPE_OWNER_GROUP        =4;
const         TYPE_OWNER_VISTA        =3;
const         TYPE_OWNER_ZONE         =2;
const         TYPE_OWNER_READER       =1;
const         TYPE_OWNER_OBJECT       =0;

// ������ ������� ���

  const APPLICATION_MESDRIVER           =00;
  const APPLICATION_SUDSERVER           =01;
  const APPLICATION_NBFIND              =02;
  const APPLICATION_NBSERVER            =03;
  const APPLICATION_MESSERVER           =04;
  const APPLICATION_KSBSERVER           =05;
  const APPLICATION_DRAWSERV            =06;
  const APPLICATION_CONFIGOS            =07;
  const APPLICATION_WHATHAPP            =08;
  const APPLICATION_SERVERTV            =09;
  const APPLICATION_KEYBOARDTV          =10;
  const APPLICATION_GAURDIAN            =11;
  const APPLICATION_BAKSHED             =12;
  const APPLICATION_SUDSERVERAAN        =13;
  const APPLICATION_MEGADRIVER          =14;
  const APPLICATION_TRANE               =15;
  const APPLICATION_DRIVERRIC           =16;
  const APPLICATION_GS2001              =17;
  const APPLICATION_CONTROL             =18;
  const APPLICATION_FOTOPOST            =19;
  const APPLICATION_KSBLOADER           =20;
  const APPLICATION_SPRITE              =21;
  const APPLICATION_ANN100              =22;
  const APPLICATION_TESTER              =23;
  const APPLICATION_DRV_VISTA           =24;
  const APPLICATION_DRV_DS1820          =25;
  const APPLICATION_DRV_R7              =26;
  const APPLICATION_DRV_R7_2            =27;
  const APPLICATION_DRV_R8              =29;  
  const APPLICATION_ANN100_2            =32;
  const APPLICATION_S20                 =33;
  const APPLICATION_COREORION           =44;
  const APPLICATION_C2000PP             =45;
  const APPLICATION_DRV_CU01            =46;
  const APPLICATION_INTEGRSERV          =47;

// ���������� ���
  const SYSTEM_OPS                      =0;
  const SYSTEM_SUD                      =1;
  const SYSTEM_TV                       =2;
  const SYSTEM_PROGRAM                  =5;
  const SYSTEM_KLIMAT                   =6;
  const SYSTEM_EVS                      =7;


  const WORK_MONITOR                            =0;
  const ALARM_MONITOR                           =$4000;

  const         ZT_NOT_USED                    =00;
  const         ZT_ENTER_EXIT_1                =01;  //10  BURGLARY
  const         ZT_ENTER_EXIT_2                =02;  //11  BURGLARY
  const         ZT_PERIMETR                    =03;  //12  BURGLARY
  const         ZT_INT_FOLLOWER                =04;  //13  BURGLARY
  const         ZT_DAY_NIGTH                   =05;  //14  BURGLARY (TROUBLE)
  const         ZT_HR_SILENT                   =06;  //15  PANIC
  const         ZT_HR_AUDIBLE                  =07;  //16  PANIC
  const         ZT_HR_AUX                      =08;  //17  AUXILARY  (������ ��� ��������� �������, ����� ����� ������ ���������)
  const         ZT_FIRE                        =09;  //18  FIRE TRB
  const         ZT_INT_DELAY                   =10;  //19  BURGLARY

  const         ZT_ARMING_STAY                 =20;  //20
  const         ZT_ARMING_AWAY                 =21;  //21
  const         ZT_DISARMING                   =22;  //22
  const         ZT_NO_ALARM                    =23;  //23

{
  const      STATUS_ZONE_NOTBIG     = $1000; // ��� ���������� �� BIG
  const      STATUS_ZONE_ALARM      = $2000; //
  const      STATUS_ZONE_NOTACTIVE  = $4000; // ZONE ���������
  const      STATUS_ZONE_NOTLINK    = $8000; // ��� ���������� �� ZONE
  const      STATUS_ZONE_BYPASS     = $0004;
  const      STATUS_ZONE_ARMED      = $0002;
  const      STATUS_ZONE_NOTREADY   = $0001;
}

//-----------------------------------------------------------------------------

// ��� �����������
  const      PASS_READER                       =0;// ������
  const      ENTER_READER                      =1;// ������
  const      EXIT_READER                       =2;// �������
  const      PIN_READER                        =3;// �������

// ��������� �����������
  const      READER_CLOSE                      =0;
  const      READER_CARD                       =1;
  const      READER_CARD_OR_PIN                =2;
  const      READER_CARD_AND_PIN               =3;
  const      READER_OPEN                       =4;
  const      READER_FACILITY                   =5;
  const      READER_ACCESS_DENIED              =6;
  const      READER_ACCESS_GRANTED             =7;

//-------------------------------------------------------------------------------------------

 const MAN_ARMED_GROUP                 = 3010; // $0BC2
 const MAN_DISARMED_GROUP              = 3011; // $0BC3
 const MAN_BYPASS_ZONE                 = 3012; // $0BC4   ����� ����
 const MAN_RESET_BYPASS_ZONE           = 3013; // $0B�5   ������ ������ ����

 const VIRT_ARMED_GROUP                = 3016; //
 const VIRT_DISARMED_GROUP             = 3017; //
 const VIRT_ALARM_GROUP                = 3018; //
 const VIRT_DISALARM_GROUP             = 3019; //

 const FIND_ELEMENT_IN_GROUP           = 3020; //

 //-------------------------------------------------------------------------------------------

 const PRN_LOG_50_FULL                 = 4000;
 const PRN_LOG_90_FULL                 = 4001;
 const PRN_SYSTEM_RESET                = 4002;
 const PRN_LOW_BATTERY                 = 4003;
 const PRN_ARMED                       = 4004;
 const PRN_ARMED_AUTO                  = 4005;
 const PRN_DISARMED                    = 4006;
 const PRN_PANIC                       = 4007;
 const PRN_PNC_RST                     = 4008;
 const PRN_BURGLARY                    = 4009;
 const PRN_BURG_RST                    = 4010;
 const PRN_FIRE_TRB                    = 4011;
 const PRN_FRTR_RST                    = 4012;
 const PRN_RECENT_ARM                  = 4013;
 const PRN_PRINTER_RSTR                = 4014;
 const PRN_PRINTER_FAIL                = 4015;
 const PRN_CANCEL                      = 4016;
 const PRN_AUXILARY                    = 4017;
 const PRN_AUX_RST                     = 4018;
 const PRN_TROUBLE                     = 4019;
 const PRN_TRBL_RST                    = 4020;
 const PRN_FIRE                        = 4021;
 const PRN_FIRE_RST                    = 4022;
 const PRN_BATTERY_FAIL                = 4023;
 const PRN_BYPASS                      = 4024;
 const PRN_BYP_RST                     = 4025;
 const PRN_EXP_SHRT                    = 4026;
 const PRN_EXP_RST                     = 4027;
 const PRN_LOG_OVERFLOW                = 4028;
 const PRN_RPM_SUPR                    = 4029;
 const PRN_RPM_RST                     = 4030;
 const PRN_ARMED_STAY                  = 4031;
 const PRN_TAMPER                      = 4032;
 const PRN_TMPR_RST                    = 4033;
 const PRN_AC_LOSS                     = 4034;
 const PRN_AC_RESTORE                  = 4035;
 const PRN_PROGRM_ENTRY                = 4036;
 const PRN_PROGRAM_EXIT                = 4037;
 const PRN_PROG_CHANGE                 = 4038;
 const PRN_LOW_BATT_RST                = 4039;
 const PRN_USRXX_ADD_BY                = 4040;
 const PRN_USRXX_DEL_BY                = 4041;
 const PRN_LOG_CLEARED                 = 4042;
 const PRN_ARMED_EARLY                 = 4043;
 const PRN_DISRMD_LATE                 = 4044;
 const PRN_ARMED_LATE                  = 4045;
 const PRN_SKED_CHANGE                 = 4046;
 const PRN_FAIL_TO_COMM                = 4047;
 const PRN_DURESS                      = 4048;

 //------------------------------------------------------------------------------

 const VIDEO_UNIPLEX_CAMERA_ONOFF      = 5022;
 const VIDEO_UNIPLEX_CAMERA_FAIL       = 5023;
 const VIDEO_SENDKEY_ERNITEC           = 5100;
 const VIDEO_SENDKEY_UNIPLEX           = 5101;
 const VIDEO_CAMERA_FAIL               = 5102;
 const VIDEO_CAMERA_TEST               = 5103;
 const VIDEO_CAMERA_ON                 = 5104;
 const VIDEO_MONITOR                   = 5001;
 const VIDEO_CAMERA                    = 5002;
 const VIDEO_POS                       = 5003;
 const VIDEO_NUM                       = 5004;
 const VIDEO_EMPTY                     = 5005;
 const VIDEO_CAMFIXED                  = 5006;
 const VIDEO_MONNF                     = 5007;
 const VIDEO_REMSYSNV                  = 5008;
 const VIDEO_CAMNV                     = 5009;
 const VIDEO_SEQNF                     = 5010;
 const VIDEO_KBDUM                     = 5011;
 const VIDEO_ADPRO                     = 5012;
 const VIDEO_NOTDEFINED                = 5013;
 const VIDEO_PRESSMON                  = 5014;
 const VIDEO_MONITOR_CAMERA            = 5015;
 const VIDEO_RUN_SCENARY               = 5016;
 const VIDEO_RUN_DVMD_PROGRAM          = 5017;
 const VIDEO_CAMERA_ON_SPOT            = 5018;
 const VIDEO_CAMERA_ON_MAIN            = 5019;

 const VIDEO_SPRITE_ONLINE             = 5020;
 const VIDEO_SPRITE_OFFLINE            = 5021;

//-----------------------------------------------------------------------------
 const SUD_AUX1_RIC                    = 223;
 const SUD_RESETAUX1_RIC               = 208;
 const SUD_SET_LINK_READER             = 194;
 const SUD_LOST_LINK_READER            = 195;

 const OUT_SET	                       = 253;
 const SUD_TIMEZONE_SETTED             = 252;
 const CONNECT_SET                     = 251;
 const TRYLINK                         = 249;
 const START                           = 248;
 const HANGLOW                         = 247;
 const HANGHIGH                        = 246;
 const NOTNETDEVICE                    = 245;
 const RESTORE_NETDEVICE               = 244;
 const LOST_NETDEVICE                  = 243;

 const ANTI_SET                        = 228;
 const NOTADDCARD_SET                  = 226;
 const SETCOMPUTER                     = 225;
 const LOSTCOMPUTER                    = 224;
 const SUD_GRANTED_BUTTON              = 237;
 const SUD_HELD                        = 222;
 const SUD_FORCED                      = 221;
 const SUD_RESETHELD                   = 220;
 const SUD_RESETFORCED                 = 219;

 const SUD_OK_ENTER                    = 1032; //������ ��������
 const SUD_OK_NOT_ENTER                = 1033; //������ �� ��������
 const SUD_DOOR_CLOSE                  = {1}218;
 const SUD_DOOR_OPEN                   = {1}217;
 const SUD_LOCK_CLOSE                  = 1257;
 const SUD_LOCK_OPEN                   = 1242;

 const ANTI_COM                        = 209;
 const BRANCH_UNSIGNED                 = 193;
 const START_RS90                      = 192;
 const RIC_MODE                        = 191;
 const BEGIN_COMMAND                   = 139;
 const END_COMMAND                     = 140;

 const SUD_GRANTED_FACILITY            = 130; 
 const SUD_ACCESS_GRANTED              = 131;
 const SUD_BAD_FACILITY                = 132;
 const SUD_BAD_CARD_FORMAT             = 133;
 const SUD_NO_CARD                     = 134;
 const SUD_CALC_TIMEZONE               = 135;
 const SUD_BAD_PIN                     = 136;
 const SUD_BAD_LEVEL                   = 138;
 const SUD_BAD_APB                     = 148;
 const SUD_CHECK_RIGHT                 = 238;
 const SUD_SET_READER_MODE             = 6000;
 const SUD_GET_MODE_READER             = 6001;
 const SUD_ADD_CARD                    = 6002;
 const SUD_DEL_CARD                    = 6003;
 const SUD_SET_DATETIME                = 6004;
 const SUD_SETTED_DATETIME             = 232;//6005;
 const SUD_ADDED_CARD                  = 230;//6006;
 const SUD_DELETED_CARD                = 229;//6007;
 const SUD_SET_HOLIDAY                 = 6008;
 const SUD_SETTED_HOLIDAY              = 231;
 const SUD_SET_MASK                    = 6009;
 const SUD_SETTED_MASK                 = 254;//6010;
 const SUD_SET_READER_FULL             = 6011;
 const SUD_GET_READER_DATABASE         = 6012;
 const SUD_SET_LEVEL                   = 6013;
 const SUD_SET_LEVELS                  = 6014;
 const SUD_LOAD_LOGIC_LEVEL            = 6015;
 const SUD_SET_TIMEZONE                = 6016;
 const SUD_SET_TIMEZONES               = 6017;
 const SUD_CHANGE_BRANCH               = 6018;
 const SUD_SETTED_LEVEL                = 255;
 const COMMAND_OPEN_DOOR               = 235;
 const SUD_TEST                        = 170;
 const AAN100_SET_TIMEZONE             = 6019;
 const AAN100_SET_LEVEL                = 6020;
 const AAN100_SET_MASK                 = 6021;
 const AAN100_SET_DATE                 = 6022;
 const AAN100_W_READER                 = 6023;
 const AAN100_W_FORMAT                 = 6024;
 const SUD_ACCESS_DENIED               = 6025;
 const SUD_ACCESS_CHOOSE               = 6026;
 const SUD_UNKNOW_MESSAGE              = 6027;
 const SUD_TAMPER_RIC                  = 6028;
 const SUD_RESETTAMPER_RIC             = 6029;
 const AAN100_SET_HOLIDAY              = 6030;
 const AAN100_WW_FORMAT                = 6031;
 const DRIVERRIC_REQUEST               = 6032;
 const DRIVERRIC_GRANTED               = 6033;
 const DRIVERRIC_DENIED                = 6034;
 const DRIVERRIC_ERROR                 = 6035;


 const SUD_LINK_STATE                  = 6038;
 const SUD_TAMPER_STATE                = 6039;
 const SUD_FORCE_STATE                 = 6040;
 const SUD_HELD_STATE                  = 6041;
 const SUD_AUX_STATE                   = 6042;
 const SUD_READ_STATE                  = 6043;
 const SUD_MODE_STATE                  = 6044;
 const SUD_DOWNLOAD_CARDS              = 6045;
 const SUD_RESET_APB_CARD              = 6046;
 const SUD_DOWNLOADED_CARDS            = 6047;

 const SUD_FIND_METAL                  = 6048;
 const SUD_ONE_MAN                     = 6049; 

 const PCE_OUTPUT_ENABLED              = 242;
 const PCE_OUTPUT_DISABLED             = 257;

//------------------------------------------------------------------------------

  const         SWITCH_PLAN                       =99;

  const         LOST_LINK_TAGET                   =7000;
  const         SET_LINK_TAGET                    =7001;


  const         KEYBOARD_DRAW                     =7011;
  const         REQUEST_KEYBOARD_ARMED            =7012;
  const         REQUEST_KEYBOARD_DISARMED         =7013;
  const         REQUEST_KEYBOARD_STATUS           =7015;

  const         START_PROGRAM                     = 7014;
  const         STOP_PROGRAM                      = 7017;//��������� ����������
  const         NET_TEST                          = 7034;//
  const         KILL_PROGRAM                      = 7022;//���������� ���������
  const         CHECK_LIVE_PROGRAM                = 7025;//
  const         LOST_LIVE_PROGRAM                 = 7026;//
  const         I_LIVE_PROGRAM                    = 7027;//
  const         SET_TIME                          = 7028;//
  const         EXIT_PROGRAM                      = 7029;//�������� ���������
  
  const         CONTROLSTATE_ERROR_ARMED          = 7023;//
  const         CONTROLSTATE_OK_ARMED             = 7024;//
  const         CONTROLSTATE_ERROR_DISARMED       = 7032;//
  const         CONTROLSTATE_OK_DISARMED          = 7033;//

  const         KEYVISTA_PART_READY               = 4100; // ������ �����
  const         KEYVISTA_PART_NOTREADY            = 4101; // ������ �� �����
  const         KEYVISTA_PART_ARMED               = 4102; // ������ ��� �������
  const         KEYVISTA_PART_DISARMED            = 4103; // ������ ��� ������

  const         STATE_PART_ARMED                  = 4104; // ���� ������ �������� ���� ������ ��������
  const         STATE_PART_READY                  = 4105; // ���� ������ �������� ���������� ��������
  const         STATE_ZONE_ENABLED                = 4106; // ���������������
  const         STATE_ZONE_READY                  = 4107; // ���� ������ �������� ���������� ���

  const         COMMAND_PART_ARMED                = 4108; // ��������� �� ������
  const         COMMAND_PART_DISARMED             = 4109; // ����� � ������
  const         COMMAND_ZONE_BYPASS               = 4110; // ����� ����

  const         KEYVISTA_ZONE_ALARM               = 4111; // ���� � �������
  const         KEYVISTA_ZONE_CHECK               = 4112; // ���� �� ��������
  const         KEYVISTA_ZONE_FAULT               = 4113; // ���� �� ������
  const         KEYVISTA_ZONE_BYPASS              = 4114; // ���� � BYPASSe

  const         KEYVISTA_LOBAT                    = 4115; // ������ ���������� �� �������
  const         KEYVISTA_OKBAT                    = 4116; // ������� � �����
  const         PANEL_REFRESH                     = 4117; // ������ �� ������ ��������� ��� � �������� ( ������� �������� STATE_... )
  const         COMMAND_VISTA_CONFIG              = 4118; // ������������ ��� (������ �� ����� � ������� � ��� �������)
  const         STATE_ZONE_ALARM                  = 4119; // ���� ������ �������� ������� ���
  const         KEYVISTA_ZONE_ALARM_RESET         = 4120; // ������� � ���� ��������
  const         KEYVISTA_ZONE_READY               = 4121; // ���� ������
  const         KEYVISTA_PART_BYPASS              = 4122; // ������ � BYPASS
  const         STATE_PART_BYPASS                 = 4123; // ���� ������ �������� ���� BYPASS ��������
  const         KEYVISTA_ZONE_BYPASS_RESET        = 4124; // ���� � BYPASSe �����
  const         STATE_ZONE_BYPASS                 = 4125; // ���� ������ �������� BYPASS ���

  const         COMMAND_DISARMED_ZONE             = 4126; // ����� ���� � ������
  const         COMMAND_ARMED_ZONE                = 4127; // ��������� ���� �� ������
  const         KEYVISTA_ZONE_CHECK_RESET         = 4128; //
  const         KEYVISTA_ZONE_ARMED               = 4129; // ���� ��� �������
  const         KEYVISTA_ZONE_DISARMED            = 4130; // ���� ��� ������

  const         KEYBOARD_FAILED                   = 4131; //
  const         KEYBOARD_RESTORE                  = 4132; //
  const         VIRT_ALARM_ZONE                   = 4133; // ���������� �������� �����������
  const         VISTA_ENABLED_ZONE                = 4134; // ������ ��������� ������������������ ���

  const         PRN_SILENT_PANIC                  = 4135; // ��������� �� PRN_PANIC ����� ������� ���� ����
  const         PRN_AUDIBLE_PANIC                 = 4136; // ��������� �� PRN_PANIC ����� ������� ���� ����

  const         KEYVISTA_PART_BYPASS_RESET        = 4137; // ������ ����� ��  BYPASS
  const         VIRT_ARMED_ZONE                   = 4138; // ���������� �������� �����������
  const         VIRT_DISARMED_ZONE                = 4139; // ���������� �������� �����������

  const         STATE_ZONE_ARMED                  = 4140; // ���� ������ �������� ���� ������ ���
  const         STATE_PART_ALARM                  = 4141; // ���� ������ �������� ���� ������� ��������

  const         KEYVISTA_PART_ALARM               = 4142; // ������� � �������
  const         KEYVISTA_PART_ALARM_RESET         = 4143; // ����� ������� � �������
  const         KEYVISTA_PART_FAULT               = 4144; // ��������� � �������
  const         KEYVISTA_PART_FAULT_RESET         = 4145; // ����� ��������� � �������
  const         KEYVISTA_PART_CHECK               = 4146; // ������������� � �������
  const         KEYVISTA_PART_CHECK_RESET         = 4147; // ����� ������������� � �������
  const         KEYVISTA_ZONE_FAULT_RESET         = 4148; // ������� � ���� ��������

  const         STATE_PART_CHECK                  = 4149; // ���� ������ �������� ���� ������������� ��������
  const         STATE_PART_FAULT                  = 4150; // ���� ������ �������� ���� ��������� ��������

  const         STATE_ZONE_CHECK                  = 4151; // ���� ������ �������� ���� ������������� ���
  const         STATE_ZONE_FAULT                  = 4152; // ���� ������ �������� ���� ��������� ���
  const         STATE_VISTA                       = 4153;
  const         KEY_PRINTER_RSTR                  = 4154;
  const         KEY_PRINTER_FAIL                  = 4155;
  const         KEY_ERROR_PROG                    = 4156;

  const         KEYVISTA_AC_LOSS                  = 4157; // ������ ���������� �� �������
  const         KEYVISTA_AC_OK                    = 4158; // ������� � �����
  const         KEYVISTA_ZONE_ATTENTION           = 4159;
  const         COMMAND_ZONE_RESET_ALARM          = 4160;
  const         COMMAND_READ_PART                 = 4161;
  const         COMMAND_READ_ZONE                 = 4162;

  const         VST_ARMED                         = 4204;
  const         VST_DISARMED                      = 4206;
  const         PANEL_RESTART                     = 4207;
  const         VISTA_STATE                       = 4208;

  const         MEGA_ZONE_READY                   = 1001;
  const         MEGA_ZONE_NOT_READY               = 1002;
  const         MEGA_ZONE_ARMED                   = 1003;
  const         MEGA_ZONE_DISARMED                = 1004;
  const         MEGA_ZONE_ALARM                   = 1005;
  const         MEGA_ZONE_ALARM_RESET             = 1006;
  const         MEGA_ZONE_BYPASS                  = 1007;
  const         MEGA_ZONE_BYPASS_RESET            = 1008;

  
  //------------------------------------------------------
  //                       �����-08
  //------------------------------------------------------
  const         R8_CONNECT_FALSE                  = 9100;         //���������� ����� � ���+
  const         R8_CONNECT_TRUE                   = 9101;         //��� �� ����� +
  const         R8_SYSERROR                       = 9102;         //��������� ������ ���+
  const         R8_OK                             = 9103;         //��� � ����� (����� ������. ������)+
  const         R8_COMMAND_PANEL_REFRESH          = 9104;         //������ ��������� ���,���, ��, ��
  const         R8_COMMAND_SH_ARM                 = 9105;         //�� ��������� �� ������+
  const         R8_COMMAND_SH_DISARM              = 9106;         //�� ����� � ������+
  const         R8_COMMAND_SH_OFF                 = 9107;         //�� ���������+
  const         R8_COMMAND_SH_ON                  = 9108;         //�� ����������+
  const         R8_COMMAND_SH_RESTORE             = 9109;         //�� ������������+
  const         R8_SH_ARMED                       = 9110;         //�� ��� �������+
  const         R8_SH_DISARMED                    = 9111;         //�� ��� ������+
  const         R8_SH_READY                       = 9112;         //�� �����+
  const         R8_SH_NOTREADY                    = 9113;         //�� �� �����+
  const         R8_SH_CHECK                       = 9114;         //�� ����������+
  const         R8_SH_ALARM                       = 9115;         //�� � �������+
  const         R8_SH_RESTORE                     = 9116;         //�� ������������ (�������� �� ������. �����.)
  const         R8_SH_OFF                         = 9117;         //�� ��������+
  const         R8_SH_ON                          = 9118;         //�� ���������+
  const         R8_SH_HW_OK                       = 9119;         //�� ������������ � �����
  const         R8_SH_HW_FAULT                    = 9120;         //�� ������������ ����������
  const         R8_BLOCK_SH_ENABLED               = 9121;         //���� ��������� ��+
  const         R8_BLOCK_SH_READY                 = 9122;         //���� ������� ��+
  const         R8_BLOCK_SH_ALARM                 = 9123;         //���� �� � �������+
  const         R8_BLOCK_SH_OFF                   = 9124;         //���� ����������� ��+
  const         R8_BLOCK_SH_ARMED                 = 9125;         //���� �� ��� ��������+
  const         R8_BLOCK_SH_CHECK                 = 9126;         //���� ����������� ��+
  const         R8_BLOCK_SH_HW_FAULT              = 9127;         //���� �� �� �����+
  const         R8_COMMAND_ZONE_ARM               = 9128;         //���� ��������� �� ������+
  const         R8_COMMAND_ZONE_DISARM            = 9129;         //���� ����� � ������+
  const         R8_ZONE_ARMED                     = 9130;         //���� ��� �������+
  const         R8_ZONE_DISARMED                  = 9131;         //���� ��� ������+
  const         R8_ZONE_READY                     = 9132;         //���� ������+
  const         R8_ZONE_NOTREADY                  = 9133;         //���� �� ������+
  const         R8_ZONE_CHECK                     = 9134;         //���� �� ���������+
  const         R8_ZONE_ALARM                     = 9135;         //���� � �������+
  const         R8_ZONE_RESTORE                   = 9136;         //���� �������������+
  const         R8_ZONE_SH_OFF                    = 9137;         //� ���� ���� ����������� ��
  const         R8_ZONE_SH_ON                     = 9138;         //� ���� ��� �� ����������
  const         R8_BLOCK_ZONE_READY               = 9139;         //���� ������� ���+
  const         R8_BLOCK_ZONE_ALARM               = 9140;         //���� ��� � �������+
  const         R8_BLOCK_ZONE_CHECK               = 9141;         //���� ����������� ���+
  const         R8_BLOCK_ZONE_ARMED               = 9142;         //���� ��� ��� ��������+
  const         R8_BLOCK_ZONE_OFF                 = 9143;         //���� ����������� ���+
  const         R8_CU_CONNECT_OFF                 = 9144;         //�� ������ �����+
  const         R8_CU_CONNECT_ON                  = 9145;         //�� �������������� �����+
  const         R8_BLOCK_CU_CONNECT               = 9146;         //���� �� �� �����     (!)
  const         R8_COMMAND_RELAY_0                = 9147;         //���� ���������+
  const         R8_COMMAND_RELAY_1                = 9148;         //���� ��������+
  const         R8_RELAY_0                        = 9149;         //���� ���������+
  const         R8_RELAY_1                        = 9150;         //���� ��������+
  const         R8_RELAY_HW_OK                    = 9151;         //���� ������������ � �����
  const         R8_RELAY_HW_FAULT                 = 9152;         //���� ������������ ����������
  const         R8_BLOCK_RELAY_1                  = 9153;         //���� ���������� ����
  const         R8_BLOCK_RELAY_CONNECT            = 9154;         //���� ���� �� �����
  const         R8_UPS_ACCESS                     = 9155;         //�������� ������� ���-
  const         R8_UPS_OUT1_BAD                   = 9156;         //��� ������������� ������ 1+
  const         R8_UPS_OUT1_OK                    = 9157;         //��� �������������� ������ 1+
  const         R8_UPS_OUT2_BAD                   = 9158;         //��� ������������� ������ 2+
  const         R8_UPS_OUT2_OK                    = 9159;         //��� �������������� ������ 2+
  const         R8_UPS_IN220_BAD                  = 9160;         //��� ������������� ����� 220+
  const         R8_UPS_IN220_OK                   = 9161;         //��� �������������� ����� 220+
  const         R8_UPS_BAT_BAD                    = 9162;         //������ �� ���+ {��� ������������� ��+}
  const         R8_UPS_BAT_OK                     = 9163;         //����� � ����� �� ��� ��+ {��� �������������� ��+}
  const         R8_UPS_RESERV_ON                  = 9164;         //��� ������� �� ������+
  const         R8_UPS_RESERV_OFF                 = 9165;         //��� �������������� ������� 220+
  const         R8_UPS_BAT_DISCONNECT             = 9166;         //��� ���������� ��+
  const         R8_UPS_BAT_CONNECT                = 9167;         //��� ����������� ��+
  const         R8_USER_ENTER                     = 9168;         //������ ������� ������ ���+
  const         R8_USER_EXIT                      = 9169;         //����� ������� ������ ���+
  const         R8_POWER_UP                       = 9170;         //��������� ���+
  const         R8_POWER_DOWN                     = 9171;         //���������� ���+
  const         R8_ENTER_CONF                     = 9172;         //���� � ���������������� ���+
  const         R8_UNKNOWN_USER                   = 9173;         //������ ����������� ���������+
  const         R8_LOCK_KEYBOARD                  = 9174;         //���������� ���������� ��� ��� �����������+
  const         R8_OPEN                           = 9175;         //�������� ������� ���+
  const         R8_RESERV_POWER                   = 9176;         //������� �� ��������� �������+
  const         R8_NORMAL_POWER                   = 9177;         //�������������� �������� �������+
  const         R8_WORKSETTINGS                   = 9178;         //������� � ��������� ����������+
  const         R8_SYNC_TIME                      = 9179;         //������������� ����� ���+
  const         R8_TERM_ON                        = 9180;         //�������� ���������, � �����+
  const         R8_TERM_OFF                       = 9181;         //�������� ��������+
  const         R8_TERM_HW_OK                     = 9182;         //�������� ������������ � �����
  const         R8_TERM_HW_FAULT                  = 9183;         //�������� ������������ ����������
  const         R8_BCP_OPEN                       = 9184;         //�������� ���          (!)
  const         R8_DRV_READY                      = 9185;         //������� ����� � ������
  const         R8_CU_OPEN                        = 9186;         //�������� ��+  (!)
  const         R8_SMALL_CONNECT_FALSE            = 9187;         //��������������� (����� ������) ���������� ����� � ���+
  const         R8_SH_NORIGTH                     = 9188;         //��� ���� �� ���������� ��
  const         R8_RELAY_NORIGTH                  = 9189;         //��� ���� �� ���������� ����
  const         R8_TERM_NORIGTH                   = 9190;         //��� ���� �� ���������� ����������
  const         R8_CU_CLOSE                       = 9191;         //�� ������ ������
  const         R8_BLOCK_CU_OPEN                  = 9192;         //���� �������� �� (!)
  const         R8_RETURN_COMMAND_FROM_ROSTEK     = 9193;         //����������� ������� � ��               (!)
  const         R8_SH_RESET                       = 9194;         //��. �����                              (!)
  const         R8_SH_BYPASS                      = 9195;         //��. ������� �� �������� � ����������      (!)
  const         R8_SH_INDELAY                     = 9196;         //�� �������� �� ����   (!)
  const         R8_SH_OUTDELAY                    = 9197;         //�� �������� �� �����  (!)
  const         R8_BAT_LOW                        = 9198;         //������ ��             (!)
  const         R8_BAT_NORMAL                     = 9199;         //�������������� ��     (!)
  const         R8_COMMAND_CU_CREATE              = 9200;         //�� �������+
  const         R8_COMMAND_CU_CHANGE              = 9201;         //�� �������������+
  const         R8_COMMAND_CU_DELETE              = 9202;         //�� �������+
  const         R8_COMMAND_CU_CONFIG              = 9203;         //�� ������ ������������+
  const         R8_CU_CREATE                      = 9204;         //�� �������+
  const         R8_CU_CHANGE                      = 9205;         //�� �������������+
  const         R8_CU_DELETE                      = 9206;         //�� �������+
  const         R8_CU_CONFIG                      = 9207;         //�� ������������+
  const         R8_COMMAND_ZONE_CREATE            = 9208;         //���� �������+
  const         R8_COMMAND_ZONE_CHANGE            = 9209;         //���� �������������+
  const         R8_COMMAND_ZONE_DELETE            = 9210;         //���� �������+
  const         R8_COMMAND_ZONE_NAME_DELETE       = 9211;         //���� �� ����� �������+
  const         R8_COMMAND_ZONE_CONFIG            = 9212;         //���� ������ ������������+
  const         R8_ZONE_CREATE                    = 9213;         //���� �������+
  const         R8_ZONE_CHANGE                    = 9214;         //���� �������������+
  const         R8_ZONE_DELETE                    = 9215;         //���� �������+
  const         R8_ZONE_CONFIG                    = 9216;         //���� ������������+
  const         R8_COMMAND_SH_CREATE              = 9217;         //�� �������+
  const         R8_COMMAND_SH_CHANGE              = 9218;         //�� �������������+
  const         R8_COMMAND_SH_DELETE              = 9219;         //�� �������+
  const         R8_COMMAND_SH_SERNUM_DELETE       = 9220;         //�� ������� �� sernum+
  const         R8_COMMAND_SH_CONFIG              = 9221;         //�� ������ ������������+
  const         R8_SH_CREATE                      = 9222;         //�� ������+
  const         R8_SH_CHANGE                      = 9223;         //�� ������������+
  const         R8_SH_DELETE                      = 9224;         //�� ������+
  const         R8_SH_CONFIG                      = 9225;         //�� ������������+
  const         R8_COMMAND_USER_CREATE            = 9226;         //������������ �������+
  const         R8_COMMAND_USER_CHANGE            = 9227;         //������������ �������������+
  const         R8_COMMAND_USER_DELETE            = 9228;         //������������ �������+
  const         R8_USER_CREATE                    = 9229;         //������������ ������+
  const         R8_USER_CHANGE                    = 9230;         //������������ ������������+
  const         R8_USER_DELETE                    = 9231;         //������������ ������+
  const         R8_COMMAND_TZ_CREATE              = 9232;         //�� �������+
  const         R8_COMMAND_TZ_CHANGE              = 9233;         //�� �������������+
  const         R8_COMMAND_TZ_DELETE              = 9234;         //�� �������+
  const         R8_TZ_CREATE                      = 9235;         //�� �������+
  const         R8_TZ_CHANGE                      = 9236;         //�� �������������+
  const         R8_TZ_DELETE                      = 9237;         //�� �������+
  const         R8_COMMAND_RELAY_CREATE           = 9238;         //���� �������
  const         R8_COMMAND_RELAY_CHANGE           = 9239;         //���� �������������
  const         R8_COMMAND_RELAY_DELETE           = 9240;         //���� �������
  const         R8_RELAY_CREATE                   = 9241;         //���� �������+
  const         R8_RELAY_CHANGE                   = 9242;         //���� �������������+
  const         R8_RELAY_DELETE                   = 9243;         //���� �������+
  const         R8_COMMAND_SETTIME                = 9244;         //����� ����������+
  const         R8_SETTIME                        = 9245;         //����� �����������+
  const         R8_COMMAND_GETTIME                = 9246;         //����� ���������+
  const         R8_GETTIME                        = 9247;         //����� ������+
  const         R8_COMMAND_UD_CREATE              = 9248;         //�� �������+
  const         R8_COMMAND_UD_CHANGE              = 9249;         //�� �������������+
  const         R8_COMMAND_UD_DELETE              = 9250;         //�� �������+
  const         R8_UD_CREATE                      = 9251;         //�� ������+
  const         R8_UD_CHANGE                      = 9252;         //�� ������������+
  const         R8_UD_DELETE                      = 9253;         //�� ������+
  const         R8_COMMAND_TERM_CREATE            = 9254;         //���� �������
  const         R8_COMMAND_TERM_CHANGE            = 9255;         //���� �������������
  const         R8_COMMAND_TERM_DELETE            = 9256;         //���� �������
  const         R8_COMMAND_TERM_SERNUM_DELETE     = 9257;         //���� ������� �� sernum
  const         R8_COMMAND_TERM_CONFIG            = 9258;         //���� ������ ������������
  const         R8_TERM_CREATE                    = 9259;         //���� ������
  const         R8_TERM_CHANGE                    = 9260;         //���� ������������
  const         R8_TERM_DELETE                    = 9261;         //���� ������
  const         R8_TERM_CONFIG                    = 9262;         //���� ������������
  const         R8_COMMAND_CU_ALL_DELETE          = 9263;         //������� ��� ��
  const         R8_CU_ALL_DELETE                  = 9264;         //������� ��� ��
  const         R8_COMMAND_ZONE_ALL_DELETE        = 9265;         //������� ��� ����
  const         R8_ZONE_ALL_DELETE                = 9266;         //������� ��� ����
  const         R8_COMMAND_TZ_ALL_DELETE          = 9267;         //������� ��� ��
  const         R8_TZ_ALL_DELETE                  = 9268;         //������� ��� ��
  const         R8_COMMAND_UD_ALL_DELETE          = 9269;         //������� ��� ��
  const         R8_UD_ALL_DELETE                  = 9270;         //������� ��� ��
  const         R8_COMMAND_USER_ALL_DELETE        = 9271;         //������� ���� �������������
  const         R8_USER_ALL_DELETE                = 9272;         //������� ��� ������������
  const         R8_COMMAND_RELAY_RESTORE          = 9273;         //���� ������������
  const         R8_COMMAND_AP_RESTORE             = 9274;         //�� ������������
  const         R8_SH_TEST                        = 9275;         //��. ����� ��������
  const         R8_SH_TESTPASSEDOK                = 9276;         //��. �������� ��������
  const         R8_SH_TESTTIMEOUT                 = 9277;         //��. �������� �� ��������
  const         R8_SH_WAITFORREADY                = 9278;         //��. �������� ����������
  const         R8_SH_WAITFORREADYCANCEL          = 9279;         //��. ������ �������� ����������
  const         R8_COMMAND_GR_CREATE              = 9280;         //������ �������
  const         R8_GR_CREATE                      = 9281;         //������ �������
  const         R8_COMMAND_GR_CHANGE              = 9282;         //������ �������������
  const         R8_GR_CHANGE                      = 9283;         //������ �������������
  const         R8_COMMAND_GR_DELETE              = 9284;         //������ �������
  const         R8_GR_DELETE                      = 9285;         //������ �������
  const         R8_COMMAND_GR_DELETE_ALL          = 9286;         //������� ��� ������
  const         R8_GR_DELETEALL                   = 9287;         //������ �������
  const         R8_COMMAND_GR_GET                 = 9288;         //������. ������ ������������
  const         R8_GR_GET                         = 9289;         //������ ������������
  const         R8_COMMAND_GR_GETLIST             = 9290;         //������. ������ ������������ ����
  const         R8_COMMAND_USER_APBRESET          = 9291;         //�����. �������� APB
  const         R8_USER_APBRESET                  = 9292;         //�����. APB �������
  const         R8_USER_BLOCKING                  = 9293;         //�����. ������������
  const         R8_USER_DEBLOCKING                = 9294;         //�����. �������������
  const         R8_RELAY_OFF                      = 9295;         //���� ���������+
  const         R8_RELAY_ON                       = 9296;         //���� ����������+
  const         R8_COMMAND_SH_BYPASS              = 9297;         //�� ����������
  const         R8_COMMAND_SH_RESET               = 9298;         //�� ��������
  const         R8_COMMAND_SH_TEST                = 9299;         //�� ��������

  const         R8_BAD_ARG_IN_USER_CMD            = 9300;         //�������� �������� � ������� User+/-/e ��� ServerRubeg  (!)
  const         R8_BCP_ERROR                      = 9301;         //����� �08 �� ������ �� �������                         (!)
  const         R8_RETURN_ROSTEK_CMD_ON_ERROR     = 9302;         //����������� ������� � ��                               (!)
  const         R8_BAD_ARG_IN_ROSTEK_CMD          = 9303;         //�������� �������� � ������� �� ��                      (!)

  const         R8_SELFTEST                       = 9307;         //���������������� ���. ��������������� �������� �� ������
  const         R8_RESET                          = 9308;         //����� ���
  const         R8_HANDSHAKE                      = 9310;         //������ �������
  const         R8_SH_FIRE_ALARM                  = 9311;         // (!) �����
  const         R8_SH_FIRE_ATTENTION              = 9312;         // (!) ��������

  const         R8_SH_NOTREADY_IN_CHECK           = 9319;         // (!) �� �� ����� ��� ������.+
  const         R8_SH_READY_IN_CHECK              = 9320;         // (!) �� ����� ��� ������.+
  const         R8_SH_NOTREADY_IN_ALARM           = 9321;         // (!) �� �� ����� ��� �������+
  const         R8_SH_READY_IN_ALARM              = 9322;         // (!) �� ����� ��� �������+
  
  const         R8_TC_RESTORE                     = 9323;         // �� ������������
  const         R8_TC_HW_FAULT                    = 9324;         // �� ������������ ����������
  const         R8_TC_HW_OK                       = 9325;         // �� ������������ � �����
  const         R8_TC_NORIGTH                     = 9326;         // �� ��� ���� ����������
  const         R8_TC_CREATE                      = 9327;         // �� �������
  const         R8_TC_CHANGE                      = 9328;         // �� �������������
  const         R8_TC_DELETE                      = 9329;         // �� �������

  const         R8_COMMAND_CLEAR                  = 9331;         // ��� �������� ������������
  const         R8_COMMAND_CLEARSYSERROR          = 9332;         // ��� �������� ��������� ������
  const         R8_COMMAND_STARTCHECKCONFIG       = 9333;         // ��� ��������� ������������
  const         R8_COMMAND_BCP_RESET              = 9334;         // ��� ��������
  const         R8_COMMAND_BCP_CONSOLELOCK        = 9335;         // ����� �� ������ � ���
  const         R8_COMMAND_BCP_CONSOLEUNLOCK      = 9336;         // ����� ������������� � ���
  const         R8_COMMAND_BCP_DMQCLEARNND        = 9337;         // �������������� ���� ������� ��
  const         R8_COMMAND_BCP_DMQCLEARTCO        = 9338;         // �������������� ���� ������� ��
  const         R8_COMMAND_BCP_VAR_ASSIGN         = 9339;         // ��������� ��������� ��������
  const         R8_COMMAND_BCP_ALLUSERSETSTATE    = 9340;         // �������� APB ���� �������������
  const         R8_BCP_ALLUSERSETSTATE            = 9341;         // ����� APB ���� �������������

  const         R8_COMMAND_RN_DELETE_ALL          = 9342;         // ������� ��� ��������
  const         R8_COMMAND_RP_DELETE_ALL          = 9343;         // ������� ��� ���������
  const         R8_COMMAND_HD_DELETE_ALL          = 9344;         // ������� ��� ���������

  const         R8_RN_ALL_DELETE                  = 9345;         // ������� ��� ��������
  const         R8_RP_ALL_DELETE                  = 9346;         // ������� ��� ���������
  const         R8_HD_ALL_DELETE                  = 9347;         // ������� ��� ���������

  const         R8_PCCONNECT_OFF                  = 9351;         //������ ����� � ����
  const         R8_PCCONNECT_ON                   = 9352;         //�������������� ����� � ����

  const         R8_RELAY_CHECK                    = 9401;         // (!) ���� ����������
  const         R8_RELAY_RESTORE                  = 9402;         // (!) ���� �������������
  const         R8_RELAY_WAITON                   = 9403;         //���� �������� ���������
  const         R8_COMMAND_RELAY_CONFIG           = 9404;         //���� ������ ������������
  const         R8_RELAY_CONFIG                   = 9405;         //���� ������������+
  const         R8_COMMAND_RELAY_OFF              = 9406;         //���� ���������
  const         R8_COMMAND_RELAY_ON               = 9407;         //���� ����������

  const         R8_TERM_REQUEST                   = 9411;         // (!) ������ ������������
  const         R8_TERM_BLOCKING                  = 9412;         // (!) ������������ ������ ���������
  const         R8_TERM_AUTHORIZATIONERROR        = 9413;         // (!) ������ ����������� ������������
  const         R8_TERM_CODEFORGERY               = 9414;         // (!) ������� ������� ����. ������� �������� ����� ����, ��������� ������, ������ ����������� ������������.���.
  const         R8_TERM_RESET                     = 9415;         // (!) �������������� ������ ��������� ����� ������������
  const         R8_TERM_USERCOMMAND               = 9416;         // (!) ���������������� �������
  const         R8_TERM_CHECK                     = 9417;         // (!) �������� ����������
  const         R8_TERM_RESTORE                   = 9418;         // (!) �������� ������������
  const         R8_COMMAND_TERM_RESTORE           = 9419;         // �������� ������������
  
  const         R8_TECHNO_AREA0 	              = 9421;         // (!) ���.0. ������� ����������� �� � ��������� � ��� 0. �������� ��� ���������� ��
  const         R8_TECHNO_AREA1 	              = 9422; 	      // (!) ��� 1. ������� ����������� �� � ��������� � ��� 1. ���������� ��� ���������� ��
  const         R8_TECHNO_AREA2 	              = 9423; 	      // (!) ��� 2. ������� ����������� �� � ��������� � ��� 2
  const         R8_TECHNO_AREA3 	              = 9424; 	      // (!) ��� 3. ������� ����������� �� � ��������� � ��� 3
  const         R8_TECHNO_ALARM 	              = 9425; 	      // (!) ������� ���. ��
  const         R8_COMMAND_TERM_BLOCK             = 9426;         // �������� �������������
  const         R8_COMMAND_TERM_RESET             = 9427;         // �������� ��������
  const         R8_COMMAND_TERM_OFF               = 9428;         // �������� ���������
  const         R8_COMMAND_TERM_ON                = 9429;         // �������� ����������

  const         R8_COMMAND_HOLIDAY_EDIT           = 9431;         // ������������� ��������� (��� ����� � ����)
  const         R8_HOLIDAY_EDITED                 = 9432;         // ������������� ��������� (��� ����� � ����)

  const         R8_AP_IN                          = 9501;         //�� ����. ������ ������������ ����� ��, ������������������ �� ����.
  const         R8_AP_OUT                         = 9502;         //�� �����. ������ ������������ ����� ��, ������������������ �� �����.
  const         R8_AP_PASSENABLE                  = 9503;         //�� ������ �������� �������� �������� �����.
  const         R8_AP_DOOROPEN                    = 9504;         //�� ���������� �����.
  const         R8_AP_DOORNOCLOSED                = 9505;         //�� ��������� �����
  const         R8_AP_DOORALARM                   = 9506;         //�� ����� �����
  const         R8_AP_DOORCLOSE                   = 9507;         //�� ���������� �����
  const         R8_AP_BLOCKING                    = 9508;         //�� ������������
  const         R8_AP_DEBLOCKING                  = 9509;         //�� ���������������
  const         R8_AP_EXITBUTTON                  = 9510;         //�� ����� �� ������
  const         R8_AP_RESET                       = 9511;         //�� � ����� (�����). �������������� ����� ������������ ��� ���������������
  const         R8_AP_AUTHORIZATIONERROR          = 9512;         //�� ������ ����������� ������������
  const         R8_AP_CODEFORGERY                 = 9513;         //�� ������� ������� ����
  const         R8_AP_REQUESTPASS                 = 9514;         //�� ������ �������. ��������, ����� �� ���������������� �� ������ � ��������
  const         R8_AP_FORCING                     = 9515;         //�� ���������
  const         R8_AP_APBERROR                    = 9516;         //�� ��������� ������ �������
  const         R8_AP_ACCESSGRANTED               = 9517;         //�� ������ ��������
  const         R8_AP_ACCESSTIMEOUT               = 9518;         //�� �������

  const         R8_COMMAND_AP_PASS                = 9521;         //�� ��������� ������
  const         R8_COMMAND_AP_LOCK                = 9522;         //�� �������
  const         R8_COMMAND_AP_UNLOCK              = 9523;         //�� �������
  const         R8_COMMAND_AP_RESET               = 9524;         //�� �����
  const         R8_COMMAND_AP_OFF                 = 9525;         //�� ���������
  const         R8_COMMAND_AP_ON                  = 9526;         //�� ����������

  const         R8_AP_CHECK                       = 9531;         //��. �������������
  const         R8_AP_RESTORE                     = 9532;         //��. ������������� (�������� �� ������. �����.)
  const         R8_AP_NORIGTH                     = 9533;         //��. ��� ���� �� ����������
  const         R8_AP_HW_OK                       = 9534;         //��. ������������ � �����
  const         R8_AP_HW_FAULT                    = 9535;         //��. ������������ ����������
  const         R8_BLOCK_AP_DATA                  = 9536;         //��. ���� ������� � ���������
  //const       R8_BLOCK_AP_STATE                 = 9537;         //��. ���� ���������

  const         R8_COMMAND_AP_CREATE              = 9541;         //�� ������� +
  const         R8_COMMAND_AP_CHANGE              = 9542;         //�� ������������� +
  const         R8_COMMAND_AP_DELETE              = 9543;         //�� ������� +
  const         R8_COMMAND_AP_SERNUM_DELETE       = 9544;         //�� ������� �� sernum
  const         R8_COMMAND_AP_CONFIG              = 9545;         //�� ������ ������������
  const         R8_AP_CREATE                      = 9546;         //�� ������� +
  const         R8_AP_CHANGE                      = 9547;         //�� ������������� +
  const         R8_AP_DELETE                      = 9548;         //�� ������� +
  const         R8_AP_CONFIG                      = 9549;         //�� ������������
  const         R8_AP_OFF                         = 9550;         //�� ���������
  const         R8_AP_ON                          = 9551;         //�� ��������
  const         R8_COMMAND_APSHZMK_SET            = 9552;         //���������� �� �����
  const         R8_APSHZMK_SET                    = 9553;         //���������� �� ����� 
  const         R8_COMMAND_APSHZMK_DELETE         = 9554;         //������� �� �����
  const         R8_APSHZMK_DELETE                 = 9555;         //������ �� �����

  const         SCU_GET_DEVVER                    = 9801;         //
  const         SCU_DEVVER                        = 9802;         //
  const         SCU_GET_BOOTVER                   = 9803;         //
  const         SCU_BOOTVER                       = 9804;         //
  const         SCU_GET_DEVSTATE                  = 9805;         //
  const         SCU_DEVSTATE                      = 9806;         //
  const         SCU_GET_ALTDEVSTATE               = 9807;         //
  const         SCU_ALTDEVSTATE                   = 9808;         //
  const         SCU_GET_STATEWORD                 = 9809;         //
  const         SCU_STATEWORD                     = 9810;         //
  const         SCU_GET_PARAMARRAY                = 9811;         //
  const         SCU_PARAMARRAY                    = 9812;         //
  const         SCU_TIME_GET                      = 9813;         //
  const         SCU_TIME                          = 9814;         //
  const         SCU_TIME_EDIT                     = 9815;         //
  const         SCU_TIME_EDITED                   = 9816;         //
  const         SCU_TIME_SYNC                     = 9817;         //
  const         SCU_TIME_SYNCED                   = 9818;         //
  const         SCU_NETWORK_GET                   = 9819;         //
  const         SCU_NETWORK                       = 9820;         //
  const         SCU_NETWORK_EDIT                  = 9821;         //
  const         SCU_NETWORK_EDITED                = 9822;         //
  const         SCU_CARD_REQUEST                  = 9823;         //
  const         SCU_CARD_REQUESTED                = 9824;         //
  const         SCU_PRG_WRITE                     = 9825;         //
  const         SCU_PRG_READ                      = 9826;         //
  const         SCU_PRG_DATA                      = 9827;         //

  const         SCU_SH_EDIT                       = 9831;         // -
  const         SCU_SH_EDITED                     = 9832;         // -
  const         SCU_SH_GET                        = 9833;         // -
  const         SCU_SH                            = 9834;         // -
  const         SCU_RELAY_EDIT                    = 9835;         // -
  const         SCU_RELAY_EDITED                  = 9836;         // -
  const         SCU_RELAY_GET                     = 9837;         // -
  const         SCU_RELAY                         = 9838;         // -
  const         SCU_USK_EDIT                      = 9839;         // -
  const         SCU_USK_EDITED                    = 9840;         // -
  const         SCU_USK_GET                       = 9841;         // -
  const         SCU_USK                           = 9842;         // -
  const         SCU_AP_EDIT                       = 9843;         // -
  const         SCU_AP_EDITED                     = 9844;         // -
  const         SCU_AP_GET                        = 9845;         // -
  const         SCU_AP                            = 9846;         // -
  const         SCU_USER_ADD                      = 9847;         // -
  const         SCU_USER_ADDED                    = 9848;         // -
  const         SCU_USER_ADDNOCHECK               = 9849;         // -
  const         SCU_USER_EDIT                     = 9850;         // -
  const         SCU_USER_EDITED                   = 9851;         // -
  const         SCU_USER_DELETE                   = 9852;         // -
  const         SCU_USER_DELETED                  = 9853;         // -
  const         SCU_USER_DELETE_ALL               = 9854;         // -
  const         SCU_USER_DELETED_ALL              = 9855;         // -
  const         SCU_USER_GET                      = 9856;         // -
  const         SCU_USER                          = 9857;         // -
  const         SCU_USER_GETLIST                  = 9858;         //

  const         SCU_TC_RESTORE                    = 9861;         //
  const         SCU_TC_RESTORED                   = 9862;         //
  const         SCU_SHOCHR_DISARM                 = 9863;         //
  const         SCU_SHOCHR_DISARMED               = 9864;         //
  const         SCU_SHOCHR_ARM                    = 9865;         //
  const         SCU_SHOCHR_ARMED                  = 9866;         //
  const         SCU_SHOCHR_RESET                  = 9867;         //
  const         SCU_SHTREV_RESET                  = 9868;         //
  const         SCU_SHFIRE_RESET                  = 9869;         //
  const         SCU_SH_RESETED                    = 9870;         //
  const         SCU_RELAY_1                       = 9871;         //
  const         SCU_RELAY_IS_1                    = 9872;         //
  const         SCU_RELAY_0                       = 9873;         //
  const         SCU_RELAY_IS_0                    = 9874;         //

  const         SCU_AP_PASS                       = 9875;         //
  const         SCU_AP_PASSED                     = 9876;         //
  const         SCU_AP_LOCK                       = 9877;         //
  const         SCU_AP_LOCKED                     = 9878;         //
  const         SCU_AP_UNLOCK                     = 9879;         //
  const         SCU_AP_UNLOCKED                   = 9880;         //
  const         SCU_AP_RESET                      = 9881;         //
  const         SCU_AP_RESETED                    = 9882;         //
  const         SCU_NOTANSWER                     = 9891;         //
  const         SCU_INCORRECTANSWER               = 9892;         //
  const         SCU_HW_EDIT                       = 9893;         //+
  const         SCU_HW_EDITED                     = 9894;         //+
  const         SCU_HW_GET                        = 9895;         //
  const         SCU_HW                            = 9896;         //
  const         SCU_CARD_ADD                      = 9901;         // -
  const         SCU_CARD_ADDED                    = 9902;         // -
  const         SCU_CARD_DELETE                   = 9903;         // -
  const         SCU_CARD_DELETED                  = 9904;         // -
  const         SCU_USERMAP_WR_PERMIT             = 9905;         // -
  const         SCU_USERMAP_WR_ALL                = 9906;         // -






 
implementation

end.

