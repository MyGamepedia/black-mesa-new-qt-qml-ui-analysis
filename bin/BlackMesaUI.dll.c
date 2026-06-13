typedef unsigned char   undefined;

typedef unsigned char    bool;
typedef unsigned char    byte;
typedef unsigned int    dword;
float10
typedef unsigned long long    GUID;
typedef pointer32 ImageBaseOffset32;

typedef long long    longlong;
typedef unsigned char    uchar;
typedef unsigned int    uint;
typedef unsigned long    ulong;
typedef unsigned char    undefined1;
typedef unsigned short    undefined2;
typedef unsigned int    undefined4;
typedef unsigned long long    undefined8;
typedef unsigned short    ushort;
typedef unsigned short    wchar16;
typedef unsigned short    word;
typedef struct _s__RTTIBaseClassDescriptor _s__RTTIBaseClassDescriptor, *P_s__RTTIBaseClassDescriptor;

typedef struct _s__RTTIBaseClassDescriptor RTTIBaseClassDescriptor;

typedef struct TypeDescriptor TypeDescriptor, *PTypeDescriptor;

typedef struct PMD PMD, *PPMD;

typedef struct _s__RTTIClassHierarchyDescriptor _s__RTTIClassHierarchyDescriptor, *P_s__RTTIClassHierarchyDescriptor;

typedef struct _s__RTTIClassHierarchyDescriptor RTTIClassHierarchyDescriptor;

typedef int ptrdiff_t;

struct TypeDescriptor {
    void *pVFTable;
    void *spare;
    char name[0];
};

struct PMD {
    ptrdiff_t mdisp;
    ptrdiff_t pdisp;
    ptrdiff_t vdisp;
};

struct _s__RTTIBaseClassDescriptor {
    struct TypeDescriptor *pTypeDescriptor; // ref to TypeDescriptor (RTTI 0) for class
    dword numContainedBases; // count of extended classes in BaseClassArray (RTTI 2)
    struct PMD where; // member displacement structure
    dword attributes; // bit flags
    RTTIClassHierarchyDescriptor *pClassHierarchyDescriptor; // ref to ClassHierarchyDescriptor (RTTI 3) for class
};

struct _s__RTTIClassHierarchyDescriptor {
    dword signature;
    dword attributes; // bit flags
    dword numBaseClasses; // number of base classes (i.e. rtti1Count)
    RTTIBaseClassDescriptor **pBaseClassArray; // ref to BaseClassArray (RTTI 2)
};

typedef struct _s_UnwindMapEntry _s_UnwindMapEntry, *P_s_UnwindMapEntry;

typedef struct _s_UnwindMapEntry UnwindMapEntry;

typedef int __ehstate_t;

struct _s_UnwindMapEntry {
    __ehstate_t toState;
    void (*action)(void);
};

typedef struct _s_ESTypeList _s_ESTypeList, *P_s_ESTypeList;

typedef struct _s_ESTypeList ESTypeList;

typedef struct _s_HandlerType _s_HandlerType, *P_s_HandlerType;

typedef struct _s_HandlerType HandlerType;

struct _s_HandlerType {
    uint adjectives;
    struct TypeDescriptor *pType;
    ptrdiff_t dispCatchObj;
    void *addressOfHandler;
};

struct _s_ESTypeList {
    int nCount;
    HandlerType *pTypeArray;
};

typedef struct CLIENT_ID CLIENT_ID, *PCLIENT_ID;

struct CLIENT_ID {
    void *UniqueProcess;
    void *UniqueThread;
};

typedef struct _s_TryBlockMapEntry _s_TryBlockMapEntry, *P_s_TryBlockMapEntry;

typedef struct _s_TryBlockMapEntry TryBlockMapEntry;

struct _s_TryBlockMapEntry {
    __ehstate_t tryLow;
    __ehstate_t tryHigh;
    __ehstate_t catchHigh;
    int nCatches;
    HandlerType *pHandlerArray;
};

typedef struct _s__RTTICompleteObjectLocator _s__RTTICompleteObjectLocator, *P_s__RTTICompleteObjectLocator;

typedef struct _s__RTTICompleteObjectLocator RTTICompleteObjectLocator;

struct _s__RTTICompleteObjectLocator {
    dword signature;
    dword offset; // offset of vbtable within class
    dword cdOffset; // constructor displacement offset
    struct TypeDescriptor *pTypeDescriptor; // ref to TypeDescriptor (RTTI 0) for class
    RTTIClassHierarchyDescriptor *pClassDescriptor; // ref to ClassHierarchyDescriptor (RTTI 3)
};

typedef struct _s_FuncInfo _s_FuncInfo, *P_s_FuncInfo;

struct _s_FuncInfo {
    uint magicNumber_and_bbtFlags;
    __ehstate_t maxState;
    UnwindMapEntry *pUnwindMap;
    uint nTryBlocks;
    TryBlockMapEntry *pTryBlockMap;
    uint nIPMapEntries;
    void *pIPToStateMap;
    ESTypeList *pESTypeList;
    int EHFlags;
};

typedef struct _s_FuncInfo FuncInfo;

typedef struct _CONTEXT _CONTEXT, *P_CONTEXT;

typedef ulong DWORD;

typedef struct _FLOATING_SAVE_AREA _FLOATING_SAVE_AREA, *P_FLOATING_SAVE_AREA;

typedef struct _FLOATING_SAVE_AREA FLOATING_SAVE_AREA;

typedef uchar BYTE;

struct _FLOATING_SAVE_AREA {
    DWORD ControlWord;
    DWORD StatusWord;
    DWORD TagWord;
    DWORD ErrorOffset;
    DWORD ErrorSelector;
    DWORD DataOffset;
    DWORD DataSelector;
    BYTE RegisterArea[80];
    DWORD Cr0NpxState;
};

struct _CONTEXT {
    DWORD ContextFlags;
    DWORD Dr0;
    DWORD Dr1;
    DWORD Dr2;
    DWORD Dr3;
    DWORD Dr6;
    DWORD Dr7;
    FLOATING_SAVE_AREA FloatSave;
    DWORD SegGs;
    DWORD SegFs;
    DWORD SegEs;
    DWORD SegDs;
    DWORD Edi;
    DWORD Esi;
    DWORD Ebx;
    DWORD Edx;
    DWORD Ecx;
    DWORD Eax;
    DWORD Ebp;
    DWORD Eip;
    DWORD SegCs;
    DWORD EFlags;
    DWORD Esp;
    DWORD SegSs;
    BYTE ExtendedRegisters[512];
};

typedef struct _EXCEPTION_RECORD _EXCEPTION_RECORD, *P_EXCEPTION_RECORD;

typedef void *PVOID;

typedef ulong ULONG_PTR;

struct _EXCEPTION_RECORD {
    DWORD ExceptionCode;
    DWORD ExceptionFlags;
    struct _EXCEPTION_RECORD *ExceptionRecord;
    PVOID ExceptionAddress;
    DWORD NumberParameters;
    ULONG_PTR ExceptionInformation[15];
};

typedef struct _EXCEPTION_POINTERS _EXCEPTION_POINTERS, *P_EXCEPTION_POINTERS;

typedef struct _EXCEPTION_RECORD EXCEPTION_RECORD;

typedef EXCEPTION_RECORD *PEXCEPTION_RECORD;

typedef struct _CONTEXT CONTEXT;

typedef CONTEXT *PCONTEXT;

struct _EXCEPTION_POINTERS {
    PEXCEPTION_RECORD ExceptionRecord;
    PCONTEXT ContextRecord;
};

typedef struct DotNetPdbInfo DotNetPdbInfo, *PDotNetPdbInfo;

struct DotNetPdbInfo {
    char signature[4];
    GUID guid;
    dword age;
    char pdbpath[108];
};

typedef struct _s_CatchableTypeArray _s_CatchableTypeArray, *P_s_CatchableTypeArray;

typedef struct _s_CatchableTypeArray CatchableTypeArray;

typedef struct _s_CatchableType _s_CatchableType, *P_s_CatchableType;

typedef struct _s_CatchableType CatchableType;


// WARNING! conflicting data type names: /ehdata.h/TypeDescriptor - /TypeDescriptor

typedef void (*PMFN)(void *);

struct _s_CatchableType {
    uint properties;
    struct TypeDescriptor *pType;
    struct PMD thisDisplacement;
    int sizeOrOffset;
    PMFN copyFunction;
};

struct _s_CatchableTypeArray {
    int nCatchableTypes;
    CatchableType *arrayOfCatchableTypes[0];
};

typedef struct _s_ThrowInfo _s_ThrowInfo, *P_s_ThrowInfo;

typedef struct _s_ThrowInfo ThrowInfo;

struct _s_ThrowInfo {
    uint attributes;
    PMFN pmfnUnwind;
    int (*pForwardCompat)(void);
    CatchableTypeArray *pCatchableTypeArray;
};

typedef uint size_t;

typedef union _LARGE_INTEGER _LARGE_INTEGER, *P_LARGE_INTEGER;

typedef struct _struct_19 _struct_19, *P_struct_19;

typedef struct _struct_20 _struct_20, *P_struct_20;

typedef double LONGLONG;

typedef long LONG;

struct _struct_20 {
    DWORD LowPart;
    LONG HighPart;
};

struct _struct_19 {
    DWORD LowPart;
    LONG HighPart;
};

union _LARGE_INTEGER {
    struct _struct_19 s;
    struct _struct_20 u;
    LONGLONG QuadPart;
};

typedef union _LARGE_INTEGER LARGE_INTEGER;

typedef struct _IMAGE_SECTION_HEADER _IMAGE_SECTION_HEADER, *P_IMAGE_SECTION_HEADER;

typedef union _union_226 _union_226, *P_union_226;

typedef ushort WORD;

union _union_226 {
    DWORD PhysicalAddress;
    DWORD VirtualSize;
};

struct _IMAGE_SECTION_HEADER {
    BYTE Name[8];
    union _union_226 Misc;
    DWORD VirtualAddress;
    DWORD SizeOfRawData;
    DWORD PointerToRawData;
    DWORD PointerToRelocations;
    DWORD PointerToLinenumbers;
    WORD NumberOfRelocations;
    WORD NumberOfLinenumbers;
    DWORD Characteristics;
};

typedef struct _IMAGE_SECTION_HEADER *PIMAGE_SECTION_HEADER;

typedef struct _EXCEPTION_POINTERS EXCEPTION_POINTERS;

typedef struct IMAGE_DOS_HEADER IMAGE_DOS_HEADER, *PIMAGE_DOS_HEADER;

struct IMAGE_DOS_HEADER {
    char e_magic[2]; // Magic number
    word e_cblp; // Bytes of last page
    word e_cp; // Pages in file
    word e_crlc; // Relocations
    word e_cparhdr; // Size of header in paragraphs
    word e_minalloc; // Minimum extra paragraphs needed
    word e_maxalloc; // Maximum extra paragraphs needed
    word e_ss; // Initial (relative) SS value
    word e_sp; // Initial SP value
    word e_csum; // Checksum
    word e_ip; // Initial IP value
    word e_cs; // Initial (relative) CS value
    word e_lfarlc; // File address of relocation table
    word e_ovno; // Overlay number
    word e_res[4][4]; // Reserved words
    word e_oemid; // OEM identifier (for e_oeminfo)
    word e_oeminfo; // OEM information; e_oemid specific
    word e_res2[10][10]; // Reserved words
    dword e_lfanew; // File address of new exe header
    byte e_program[64]; // Actual DOS program
};

typedef ULONG_PTR DWORD_PTR;

typedef uint UINT_PTR;

typedef struct _FILETIME _FILETIME, *P_FILETIME;

typedef struct _FILETIME *LPFILETIME;

struct _FILETIME {
    DWORD dwLowDateTime;
    DWORD dwHighDateTime;
};

typedef struct HINSTANCE__ HINSTANCE__, *PHINSTANCE__;

struct HINSTANCE__ {
    int unused;
};

typedef BYTE *PBYTE;

typedef struct HINSTANCE__ *HINSTANCE;

typedef HINSTANCE HMODULE;

typedef int BOOL;

typedef uint UINT;

typedef struct IMAGE_OPTIONAL_HEADER32 IMAGE_OPTIONAL_HEADER32, *PIMAGE_OPTIONAL_HEADER32;

typedef struct IMAGE_DATA_DIRECTORY IMAGE_DATA_DIRECTORY, *PIMAGE_DATA_DIRECTORY;

struct IMAGE_DATA_DIRECTORY {
    ImageBaseOffset32 VirtualAddress;
    dword Size;
};

struct IMAGE_OPTIONAL_HEADER32 {
    word Magic;
    byte MajorLinkerVersion;
    byte MinorLinkerVersion;
    dword SizeOfCode;
    dword SizeOfInitializedData;
    dword SizeOfUninitializedData;
    ImageBaseOffset32 AddressOfEntryPoint;
    ImageBaseOffset32 BaseOfCode;
    ImageBaseOffset32 BaseOfData;
    pointer32 ImageBase;
    dword SectionAlignment;
    dword FileAlignment;
    word MajorOperatingSystemVersion;
    word MinorOperatingSystemVersion;
    word MajorImageVersion;
    word MinorImageVersion;
    word MajorSubsystemVersion;
    word MinorSubsystemVersion;
    dword Win32VersionValue;
    dword SizeOfImage;
    dword SizeOfHeaders;
    dword CheckSum;
    word Subsystem;
    word DllCharacteristics;
    dword SizeOfStackReserve;
    dword SizeOfStackCommit;
    dword SizeOfHeapReserve;
    dword SizeOfHeapCommit;
    dword LoaderFlags;
    dword NumberOfRvaAndSizes;
    struct IMAGE_DATA_DIRECTORY DataDirectory[16];
};

typedef struct IMAGE_SECTION_HEADER IMAGE_SECTION_HEADER, *PIMAGE_SECTION_HEADER;

typedef union Misc Misc, *PMisc;

typedef enum SectionFlags {
    IMAGE_SCN_TYPE_NO_PAD=8,
    IMAGE_SCN_RESERVED_0001=16,
    IMAGE_SCN_CNT_CODE=32,
    IMAGE_SCN_CNT_INITIALIZED_DATA=64,
    IMAGE_SCN_CNT_UNINITIALIZED_DATA=128,
    IMAGE_SCN_LNK_OTHER=256,
    IMAGE_SCN_LNK_INFO=512,
    IMAGE_SCN_RESERVED_0040=1024,
    IMAGE_SCN_LNK_REMOVE=2048,
    IMAGE_SCN_LNK_COMDAT=4096,
    IMAGE_SCN_GPREL=32768,
    IMAGE_SCN_MEM_16BIT=131072,
    IMAGE_SCN_MEM_PURGEABLE=131072,
    IMAGE_SCN_MEM_LOCKED=262144,
    IMAGE_SCN_MEM_PRELOAD=524288,
    IMAGE_SCN_ALIGN_1BYTES=1048576,
    IMAGE_SCN_ALIGN_2BYTES=2097152,
    IMAGE_SCN_ALIGN_4BYTES=3145728,
    IMAGE_SCN_ALIGN_8BYTES=4194304,
    IMAGE_SCN_ALIGN_16BYTES=5242880,
    IMAGE_SCN_ALIGN_32BYTES=6291456,
    IMAGE_SCN_ALIGN_64BYTES=7340032,
    IMAGE_SCN_ALIGN_128BYTES=8388608,
    IMAGE_SCN_ALIGN_256BYTES=9437184,
    IMAGE_SCN_ALIGN_512BYTES=10485760,
    IMAGE_SCN_ALIGN_1024BYTES=11534336,
    IMAGE_SCN_ALIGN_2048BYTES=12582912,
    IMAGE_SCN_ALIGN_4096BYTES=13631488,
    IMAGE_SCN_ALIGN_8192BYTES=14680064,
    IMAGE_SCN_LNK_NRELOC_OVFL=16777216,
    IMAGE_SCN_MEM_DISCARDABLE=33554432,
    IMAGE_SCN_MEM_NOT_CACHED=67108864,
    IMAGE_SCN_MEM_NOT_PAGED=134217728,
    IMAGE_SCN_MEM_SHARED=268435456,
    IMAGE_SCN_MEM_EXECUTE=536870912,
    IMAGE_SCN_MEM_READ=1073741824,
    IMAGE_SCN_MEM_WRITE=2147483648
} SectionFlags;

union Misc {
    dword PhysicalAddress;
    dword VirtualSize;
};

struct IMAGE_SECTION_HEADER {
    char Name[8];
    union Misc Misc;
    ImageBaseOffset32 VirtualAddress;
    dword SizeOfRawData;
    dword PointerToRawData;
    dword PointerToRelocations;
    dword PointerToLinenumbers;
    word NumberOfRelocations;
    word NumberOfLinenumbers;
    enum SectionFlags Characteristics;
};

typedef struct IMAGE_DIRECTORY_ENTRY_EXPORT IMAGE_DIRECTORY_ENTRY_EXPORT, *PIMAGE_DIRECTORY_ENTRY_EXPORT;

struct IMAGE_DIRECTORY_ENTRY_EXPORT {
    dword Characteristics;
    dword TimeDateStamp;
    word MajorVersion;
    word MinorVersion;
    ImageBaseOffset32 Name;
    dword Base;
    dword NumberOfFunctions;
    dword NumberOfNames;
    ImageBaseOffset32 AddressOfFunctions;
    ImageBaseOffset32 AddressOfNames;
    ImageBaseOffset32 AddressOfNameOrdinals;
};

typedef struct IMAGE_DEBUG_DIRECTORY IMAGE_DEBUG_DIRECTORY, *PIMAGE_DEBUG_DIRECTORY;

struct IMAGE_DEBUG_DIRECTORY {
    dword Characteristics;
    dword TimeDateStamp;
    word MajorVersion;
    word MinorVersion;
    dword Type;
    dword SizeOfData;
    dword AddressOfRawData;
    dword PointerToRawData;
};

typedef struct IMAGE_FILE_HEADER IMAGE_FILE_HEADER, *PIMAGE_FILE_HEADER;

struct IMAGE_FILE_HEADER {
    word Machine; // 332
    word NumberOfSections;
    dword TimeDateStamp;
    dword PointerToSymbolTable;
    dword NumberOfSymbols;
    word SizeOfOptionalHeader;
    word Characteristics;
};

typedef struct IMAGE_NT_HEADERS32 IMAGE_NT_HEADERS32, *PIMAGE_NT_HEADERS32;

struct IMAGE_NT_HEADERS32 {
    char Signature[4];
    struct IMAGE_FILE_HEADER FileHeader;
    struct IMAGE_OPTIONAL_HEADER32 OptionalHeader;
};

typedef struct IMAGE_LOAD_CONFIG_DIRECTORY32 IMAGE_LOAD_CONFIG_DIRECTORY32, *PIMAGE_LOAD_CONFIG_DIRECTORY32;

struct IMAGE_LOAD_CONFIG_DIRECTORY32 {
    dword Size;
    dword TimeDateStamp;
    word MajorVersion;
    word MinorVersion;
    dword GlobalFlagsClear;
    dword GlobalFlagsSet;
    dword CriticalSectionDefaultTimeout;
    dword DeCommitFreeBlockThreshold;
    dword DeCommitTotalFreeThreshold;
    pointer32 LockPrefixTable;
    dword MaximumAllocationSize;
    dword VirtualMemoryThreshold;
    dword ProcessHeapFlags;
    dword ProcessAffinityMask;
    word CsdVersion;
    word DependentLoadFlags;
    pointer32 EditList;
    pointer32 SecurityCookie;
    pointer32 SEHandlerTable;
    dword SEHandlerCount;
};

typedef struct sockaddr sockaddr, *Psockaddr;

typedef ushort u_short;

struct sockaddr {
    u_short sa_family;
    char sa_data[14];
};

typedef UINT_PTR SOCKET;

typedef struct QQmlEngine QQmlEngine, *PQQmlEngine;

struct QQmlEngine { // PlaceHolder Structure
};

typedef struct QMetaMethod QMetaMethod, *PQMetaMethod;

struct QMetaMethod { // PlaceHolder Structure
};

typedef struct QObjectData QObjectData, *PQObjectData;

struct QObjectData { // PlaceHolder Structure
};

typedef struct QFlags<enum_QMetaType::TypeFlag> QFlags<enum_QMetaType::TypeFlag>, *PQFlags<enum_QMetaType::TypeFlag>;

struct QFlags<enum_QMetaType::TypeFlag> { // PlaceHolder Structure
};

typedef struct QFlags<enum_Qt::MouseButton> QFlags<enum_Qt::MouseButton>, *PQFlags<enum_Qt::MouseButton>;

struct QFlags<enum_Qt::MouseButton> { // PlaceHolder Structure
};

typedef struct QHideEvent QHideEvent, *PQHideEvent;

struct QHideEvent { // PlaceHolder Structure
};

typedef struct QTypedArrayData<unsigned_short> QTypedArrayData<unsigned_short>, *PQTypedArrayData<unsigned_short>;

struct QTypedArrayData<unsigned_short> { // PlaceHolder Structure
};

typedef struct QMessageLogger QMessageLogger, *PQMessageLogger;

struct QMessageLogger { // PlaceHolder Structure
};

typedef struct QObject QObject, *PQObject;

struct QObject { // PlaceHolder Structure
};

typedef struct QSurface QSurface, *PQSurface;

struct QSurface { // PlaceHolder Structure
};

typedef struct QFileInfo QFileInfo, *PQFileInfo;

struct QFileInfo { // PlaceHolder Structure
};

typedef struct QScreen QScreen, *PQScreen;

struct QScreen { // PlaceHolder Structure
};

typedef struct QOpenGLContext QOpenGLContext, *PQOpenGLContext;

struct QOpenGLContext { // PlaceHolder Structure
};

typedef struct QOpenGLFunctions QOpenGLFunctions, *PQOpenGLFunctions;

struct QOpenGLFunctions { // PlaceHolder Structure
};

typedef struct QByteArray QByteArray, *PQByteArray;

struct QByteArray { // PlaceHolder Structure
};

typedef struct QFlags<enum_QUrl::ComponentFormattingOption> QFlags<enum_QUrl::ComponentFormattingOption>, *PQFlags<enum_QUrl::ComponentFormattingOption>;

struct QFlags<enum_QUrl::ComponentFormattingOption> { // PlaceHolder Structure
};

typedef struct QMutexLocker QMutexLocker, *PQMutexLocker;

struct QMutexLocker { // PlaceHolder Structure
};

typedef struct QJsonParseError QJsonParseError, *PQJsonParseError;

struct QJsonParseError { // PlaceHolder Structure
};

typedef struct QLatin1String QLatin1String, *PQLatin1String;

struct QLatin1String { // PlaceHolder Structure
};

typedef struct QOffscreenSurface QOffscreenSurface, *PQOffscreenSurface;

struct QOffscreenSurface { // PlaceHolder Structure
};

typedef struct QNetworkRequest QNetworkRequest, *PQNetworkRequest;

struct QNetworkRequest { // PlaceHolder Structure
};

typedef struct QVariant QVariant, *PQVariant;

struct QVariant { // PlaceHolder Structure
};

typedef struct QQmlIncubationController QQmlIncubationController, *PQQmlIncubationController;

struct QQmlIncubationController { // PlaceHolder Structure
};

typedef struct QMapDataBase QMapDataBase, *PQMapDataBase;

struct QMapDataBase { // PlaceHolder Structure
};

typedef struct QNetworkAccessManager QNetworkAccessManager, *PQNetworkAccessManager;

struct QNetworkAccessManager { // PlaceHolder Structure
};

typedef struct QGenericReturnArgument QGenericReturnArgument, *PQGenericReturnArgument;

struct QGenericReturnArgument { // PlaceHolder Structure
};

typedef struct QPixmap QPixmap, *PQPixmap;

struct QPixmap { // PlaceHolder Structure
};

typedef struct QThread QThread, *PQThread;

struct QThread { // PlaceHolder Structure
};

typedef struct QQuickTextureFactory QQuickTextureFactory, *PQQuickTextureFactory;

struct QQuickTextureFactory { // PlaceHolder Structure
};

typedef struct type_info type_info, *Ptype_info;

struct type_info { // PlaceHolder Structure
};

typedef struct QAccessibleInterface QAccessibleInterface, *PQAccessibleInterface;

struct QAccessibleInterface { // PlaceHolder Structure
};

typedef struct QQuickRenderControl QQuickRenderControl, *PQQuickRenderControl;

struct QQuickRenderControl { // PlaceHolder Structure
};

typedef struct QMoveEvent QMoveEvent, *PQMoveEvent;

struct QMoveEvent { // PlaceHolder Structure
};

typedef struct QPostEventList QPostEventList, *PQPostEventList;

struct QPostEventList { // PlaceHolder Structure
};

typedef struct QWindow QWindow, *PQWindow;

struct QWindow { // PlaceHolder Structure
};

typedef struct QSizeF QSizeF, *PQSizeF;

struct QSizeF { // PlaceHolder Structure
};

typedef struct QQmlComponent QQmlComponent, *PQQmlComponent;

struct QQmlComponent { // PlaceHolder Structure
};

typedef struct QFocusEvent QFocusEvent, *PQFocusEvent;

struct QFocusEvent { // PlaceHolder Structure
};

typedef struct QImage QImage, *PQImage;

struct QImage { // PlaceHolder Structure
};

typedef struct QTimer QTimer, *PQTimer;

struct QTimer { // PlaceHolder Structure
};

typedef struct QChildEvent QChildEvent, *PQChildEvent;

struct QChildEvent { // PlaceHolder Structure
};

typedef struct QKeyEvent QKeyEvent, *PQKeyEvent;

struct QKeyEvent { // PlaceHolder Structure
};

typedef struct QFlags<enum_QEventLoop::ProcessEventsFlag> QFlags<enum_QEventLoop::ProcessEventsFlag>, *PQFlags<enum_QEventLoop::ProcessEventsFlag>;

struct QFlags<enum_QEventLoop::ProcessEventsFlag> { // PlaceHolder Structure
};

typedef struct QMetaObject QMetaObject, *PQMetaObject;

struct QMetaObject { // PlaceHolder Structure
};

typedef struct QDebug QDebug, *PQDebug;

struct QDebug { // PlaceHolder Structure
};

typedef struct QPlatformSurface QPlatformSurface, *PQPlatformSurface;

struct QPlatformSurface { // PlaceHolder Structure
};

typedef struct QResizeEvent QResizeEvent, *PQResizeEvent;

struct QResizeEvent { // PlaceHolder Structure
};

typedef struct QFlags<enum_Qt::ImageConversionFlag> QFlags<enum_Qt::ImageConversionFlag>, *PQFlags<enum_Qt::ImageConversionFlag>;

struct QFlags<enum_Qt::ImageConversionFlag> { // PlaceHolder Structure
};

typedef struct QLatin1Char QLatin1Char, *PQLatin1Char;

struct QLatin1Char { // PlaceHolder Structure
};

typedef struct QQmlContext QQmlContext, *PQQmlContext;

struct QQmlContext { // PlaceHolder Structure
};

typedef struct QQuickWindow QQuickWindow, *PQQuickWindow;

struct QQuickWindow { // PlaceHolder Structure
};

typedef struct QList<class_QSslError> QList<class_QSslError>, *PQList<class_QSslError>;

struct QList<class_QSslError> { // PlaceHolder Structure
};

typedef struct QSslConfiguration QSslConfiguration, *PQSslConfiguration;

struct QSslConfiguration { // PlaceHolder Structure
};

typedef struct QString QString, *PQString;

struct QString { // PlaceHolder Structure
};

typedef struct QTabletEvent QTabletEvent, *PQTabletEvent;

struct QTabletEvent { // PlaceHolder Structure
};

typedef struct QMapNodeBase QMapNodeBase, *PQMapNodeBase;

struct QMapNodeBase { // PlaceHolder Structure
};

typedef struct QWheelEvent QWheelEvent, *PQWheelEvent;

struct QWheelEvent { // PlaceHolder Structure
};

typedef struct QPlatformNativeInterface QPlatformNativeInterface, *PQPlatformNativeInterface;

struct QPlatformNativeInterface { // PlaceHolder Structure
};

typedef struct QQmlImageProviderBase QQmlImageProviderBase, *PQQmlImageProviderBase;

struct QQmlImageProviderBase { // PlaceHolder Structure
};

typedef struct QShowEvent QShowEvent, *PQShowEvent;

struct QShowEvent { // PlaceHolder Structure
};

typedef struct QStringList QStringList, *PQStringList;

struct QStringList { // PlaceHolder Structure
};

typedef struct QVector2D QVector2D, *PQVector2D;

struct QVector2D { // PlaceHolder Structure
};

typedef struct QQuickImageProvider QQuickImageProvider, *PQQuickImageProvider;

struct QQuickImageProvider { // PlaceHolder Structure
};

typedef struct QMouseEvent QMouseEvent, *PQMouseEvent;

struct QMouseEvent { // PlaceHolder Structure
};

typedef struct QListData QListData, *PQListData;

struct QListData { // PlaceHolder Structure
};

typedef struct QUrl QUrl, *PQUrl;

struct QUrl { // PlaceHolder Structure
};

typedef struct QArrayData QArrayData, *PQArrayData;

struct QArrayData { // PlaceHolder Structure
};

typedef struct QEvent QEvent, *PQEvent;

struct QEvent { // PlaceHolder Structure
};

typedef struct QMutex QMutex, *PQMutex;

struct QMutex { // PlaceHolder Structure
};

typedef struct QFlags<enum_QArrayData::AllocationOption> QFlags<enum_QArrayData::AllocationOption>, *PQFlags<enum_QArrayData::AllocationOption>;

struct QFlags<enum_QArrayData::AllocationOption> { // PlaceHolder Structure
};

typedef struct QSize QSize, *PQSize;

struct QSize { // PlaceHolder Structure
};

typedef struct QColor QColor, *PQColor;

struct QColor { // PlaceHolder Structure
};

typedef struct QElapsedTimer QElapsedTimer, *PQElapsedTimer;

struct QElapsedTimer { // PlaceHolder Structure
};

typedef struct QNetworkReply QNetworkReply, *PQNetworkReply;

struct QNetworkReply { // PlaceHolder Structure
};

typedef struct QJsonDocument QJsonDocument, *PQJsonDocument;

struct QJsonDocument { // PlaceHolder Structure
};

typedef struct QJsonArray QJsonArray, *PQJsonArray;

struct QJsonArray { // PlaceHolder Structure
};

typedef struct QOpenGLShaderProgram QOpenGLShaderProgram, *PQOpenGLShaderProgram;

struct QOpenGLShaderProgram { // PlaceHolder Structure
};

typedef struct QMessageLogContext QMessageLogContext, *PQMessageLogContext;

struct QMessageLogContext { // PlaceHolder Structure
};

typedef struct QJsonValueRef QJsonValueRef, *PQJsonValueRef;

struct QJsonValueRef { // PlaceHolder Structure
};

typedef struct QJsonObject QJsonObject, *PQJsonObject;

struct QJsonObject { // PlaceHolder Structure
};

typedef struct QQuickItem QQuickItem, *PQQuickItem;

struct QQuickItem { // PlaceHolder Structure
};

typedef struct QTouchEvent QTouchEvent, *PQTouchEvent;

struct QTouchEvent { // PlaceHolder Structure
};

typedef struct QFlags<enum_QOpenGLShader::ShaderTypeBit> QFlags<enum_QOpenGLShader::ShaderTypeBit>, *PQFlags<enum_QOpenGLShader::ShaderTypeBit>;

struct QFlags<enum_QOpenGLShader::ShaderTypeBit> { // PlaceHolder Structure
};

typedef struct QTimerEvent QTimerEvent, *PQTimerEvent;

struct QTimerEvent { // PlaceHolder Structure
};

typedef struct QGenericArgument QGenericArgument, *PQGenericArgument;

struct QGenericArgument { // PlaceHolder Structure
};

typedef struct QDateTime QDateTime, *PQDateTime;

struct QDateTime { // PlaceHolder Structure
};

typedef struct QIODevice QIODevice, *PQIODevice;

struct QIODevice { // PlaceHolder Structure
};

typedef struct QWaitCondition QWaitCondition, *PQWaitCondition;

struct QWaitCondition { // PlaceHolder Structure
};

typedef struct QQmlNetworkAccessManagerFactory QQmlNetworkAccessManagerFactory, *PQQmlNetworkAccessManagerFactory;

struct QQmlNetworkAccessManagerFactory { // PlaceHolder Structure
};

typedef struct QPoint QPoint, *PQPoint;

struct QPoint { // PlaceHolder Structure
};

typedef struct QGuiApplication QGuiApplication, *PQGuiApplication;

struct QGuiApplication { // PlaceHolder Structure
};

typedef struct QExposeEvent QExposeEvent, *PQExposeEvent;

struct QExposeEvent { // PlaceHolder Structure
};

typedef struct QJsonValue QJsonValue, *PQJsonValue;

struct QJsonValue { // PlaceHolder Structure
};

typedef struct QFlags<enum_Qt::KeyboardModifier> QFlags<enum_Qt::KeyboardModifier>, *PQFlags<enum_Qt::KeyboardModifier>;

struct QFlags<enum_Qt::KeyboardModifier> { // PlaceHolder Structure
};

typedef struct QSurfaceFormat QSurfaceFormat, *PQSurfaceFormat;

struct QSurfaceFormat { // PlaceHolder Structure
};

typedef enum QtMsgType {
} QtMsgType;

typedef struct QCoreApplication QCoreApplication, *PQCoreApplication;

struct QCoreApplication { // PlaceHolder Structure
};

typedef struct QQmlError QQmlError, *PQQmlError;

struct QQmlError { // PlaceHolder Structure
};

typedef struct QList<class_QQmlError> QList<class_QQmlError>, *PQList<class_QQmlError>;

struct QList<class_QQmlError> { // PlaceHolder Structure
};

typedef struct QPointF QPointF, *PQPointF;

struct QPointF { // PlaceHolder Structure
};

typedef struct QChar QChar, *PQChar;

struct QChar { // PlaceHolder Structure
};

typedef struct QFlags<enum_QQmlImageProviderBase::Flag> QFlags<enum_QQmlImageProviderBase::Flag>, *PQFlags<enum_QQmlImageProviderBase::Flag>;

struct QFlags<enum_QQmlImageProviderBase::Flag> { // PlaceHolder Structure
};

typedef struct QFlags<enum_QIODevice::OpenModeFlag> QFlags<enum_QIODevice::OpenModeFlag>, *PQFlags<enum_QIODevice::OpenModeFlag>;

struct QFlags<enum_QIODevice::OpenModeFlag> { // PlaceHolder Structure
};

typedef enum RecursionMode {
} RecursionMode;

typedef enum AspectRatioMode {
} AspectRatioMode;

typedef enum FocusReason {
} FocusReason;

typedef enum ConnectionType {
} ConnectionType;

typedef enum TransformationMode {
} TransformationMode;

typedef enum Orientation {
} Orientation;

typedef enum TimeSpec {
} TimeSpec;

typedef enum ApplicationAttribute {
} ApplicationAttribute;

typedef enum GlobalColor {
} GlobalColor;

typedef enum CaseSensitivity {
} CaseSensitivity;

typedef enum MouseButton {
} MouseButton;

typedef enum KnownHeaders {
} KnownHeaders;

typedef enum Attribute {
} Attribute;

typedef enum ImageType {
} ImageType;

typedef struct Connection Connection, *PConnection;

struct Connection { // PlaceHolder Structure
};

typedef enum Call {
} Call;

typedef enum SplitBehavior {
} SplitBehavior;

typedef enum NetworkError {
} NetworkError;

typedef enum SurfaceType {
} SurfaceType;

typedef enum Operation {
} Operation;

typedef enum Priority {
} Priority;

typedef struct QSlotObjectBase QSlotObjectBase, *PQSlotObjectBase;

struct QSlotObjectBase { // PlaceHolder Structure
};

typedef struct ExternalRefCountData ExternalRefCountData, *PExternalRefCountData;

struct ExternalRefCountData { // PlaceHolder Structure
};

typedef enum RegistrationType {
} RegistrationType;

typedef struct iterator iterator, *Piterator;

struct iterator { // PlaceHolder Structure
};

typedef enum Type {
} Type;

typedef struct Data Data, *PData;

struct Data { // PlaceHolder Structure
};

typedef enum ParsingMode {
} ParsingMode;

typedef enum Status {
} Status;

typedef enum Format {
} Format;

typedef enum SwapBehavior {
} SwapBehavior;

typedef enum RenderableType {
} RenderableType;

typedef struct QPrivateSignal QPrivateSignal, *PQPrivateSignal;

struct QPrivateSignal { // PlaceHolder Structure
};

typedef int (*_onexit_t)(void);



pointer[6] vftable;
undefined4 DAT_10022088;
undefined DAT_100011a6;
undefined LAB_100114c0;
void *ExceptionList;
pointer PTR_vftable_10022000;
pointer PTR_vftable_10022008;
undefined LAB_10001a30;
undefined *PTR_self_10014348;
uint DAT_10022088;
undefined LAB_100115ac;
undefined LAB_100115e9;
char DAT_1002200c;
undefined LAB_10011651;
undefined DAT_100148c4;
pointer[12] vftable;
undefined DAT_100148f4;
undefined LAB_10011eeb;
pointer[1] vftable;
undefined LAB_1001168b;
uint DAT_100225e0;
undefined DAT_100225d8;
undefined DAT_100225dc;
undefined *PTR_staticMetaObject_10014674;
undefined LAB_10004340;
undefined LAB_100116be;
undefined *PTR_staticMetaObject_10014698;
undefined *PTR_staticMetaObject_10014208;
undefined param_3_10003ab0;
undefined param_2_10003760;
QMetaObject *param_6_10022070;
pointer[11] vftable;
pointer[30] vftable;
undefined LAB_1001174c;
undefined LAB_10011779;
undefined LAB_100117cc;
undefined LAB_100117f9;
undefined DAT_10014f80;
undefined DAT_10014e00;
undefined DAT_100225d4;
char *param_1_10014f78;
undefined FUN_10005900;
undefined FUN_10005d20;
pointer[13] vftable;
undefined *PTR_timeout_10014244;
pointer[5] vftable;
undefined *PTR_renderRequested_10014720;
undefined *PTR_sceneChanged_1001471c;
undefined LAB_100118bd;
undefined LAB_10003a90;
undefined LAB_10011904;
undefined LAB_1001193f;
undefined LAB_10011ccb;
undefined LAB_10011969;
undefined LAB_100119a9;
undefined LAB_10011a05;
undefined LAB_10011a6a;
undefined LAB_10011aa2;
undefined LAB_10011ac9;
undefined LAB_10011b02;
undefined *PTR_shared_null_1001420c;
undefined LAB_10011c5a;
char *param_1_10014fb8;
char *param_1_10014fc0;
char *param_1_10015010;
undefined LAB_10011ca1;
undefined LAB_10011cf9;
undefined LAB_10011d89;
int DAT_100225e8;
undefined LAB_10011d29;
int DAT_100225e4;
undefined LAB_10011d59;
char *param_1_100150a4;
undefined *PTR_staticMetaObject_10014694;
undefined *PTR_statusChanged_10014648;
undefined FUN_10005f20;
undefined LAB_10011df6;
undefined LAB_10011e45;
pointer[14] vftable;
undefined4 DAT_100225f0;
pointer[2] vftable;
QImage *param_1_10015194;
QByteArray *this_1001519c;
pointer[33] vftable;
undefined LAB_10011eba;
QString *this_10015200;
undefined LAB_10011f2d;
QLatin1String param_1_100151f0;
undefined LAB_10011f62;
undefined *PTR_operator=_10014120;
undefined LAB_10011f92;
undefined *PTR_~QJsonValue_1001413c;
undefined LAB_10011fd7;
undefined LAB_10012012;
undefined LAB_10012066;
undefined LAB_100120a2;
undefined LAB_100120da;
undefined LAB_10012268;
undefined LAB_1000b0a0;
undefined LAB_100122b4;
undefined *PTR_shared_null_100140e8;
undefined *PTR_shared_null_100140e4;
undefined LAB_100122fb;
undefined FUN_1000e5e0;
undefined LAB_10012349;
undefined LAB_1001238b;
undefined LAB_10012ce9;
undefined LAB_100123bb;
undefined LAB_100123e0;
undefined LAB_10012400;
undefined *PTR_QVariant_100142a4;
undefined *PTR_fromAscii_helper_100143c4;
undefined LAB_1001249a;
undefined LAB_100126af;
undefined LAB_100124c9;
undefined LAB_100124f9;
undefined LAB_10012e89;
undefined LAB_1001258a;
undefined LAB_100125e3;
char *param_1_1001529c;
undefined LAB_10012657;
undefined LAB_100126f2;
undefined LAB_10012733;
undefined LAB_100128d8;
char *param_1_1001537c;
undefined *PTR_~QVariant_100142b8;
undefined LAB_10012997;
undefined LAB_100129eb;
undefined LAB_10012a44;
undefined LAB_10012bb8;
undefined LAB_10012c5a;
undefined LAB_10012c8b;
undefined LAB_10012cbb;
undefined LAB_10012d8a;
char *param_1_1001530c;
undefined LAB_10012de5;
undefined LAB_10012e00;
undefined LAB_10012e20;
undefined LAB_10012e40;
undefined LAB_10012e60;
undefined LAB_10012ec1;
undefined LAB_10012ef2;
QString *this_10015498;
char *param_1_10015490;
char *param_1_1001549c;
char *param_1_100154a8;
char *param_1_100154b0;
undefined LAB_10013023;
undefined DAT_10022010;
undefined DAT_10022028;
undefined DAT_10022058;
undefined DAT_10022040;
undefined LAB_10013040;
undefined FUN_1000f490;
undefined FUN_1000f540;
undefined LAB_10013081;
undefined FUN_1000f4d0;
undefined FUN_1000f570;
undefined FUN_1000f5d0;
undefined FUN_1000f630;
undefined FUN_1000f660;
undefined FUN_1000f6d0;
undefined FUN_10010780;
undefined FUN_1000f450;
undefined FUN_1000f470;
undefined FUN_1000f4b0;
undefined FUN_1000f500;
undefined FUN_1000f520;
undefined DAT_1001bf80;
PVOID Ptr_10022950;
PVOID Ptr_1002294c;
int DAT_10022088;
undefined ~type_info;
int DAT_10022614;
int DAT_10022944;
undefined4 DAT_10022948;
void *DAT_10022940;
undefined DAT_10014768;
undefined DAT_10014794;
undefined DAT_10014798;
undefined DAT_100147a4;
void *StackBase;
undefined DAT_10022090;
undefined FUN_10010b2e;
int DAT_10022934;
undefined DAT_10022718;
undefined DAT_10022714;
undefined DAT_10022710;
undefined DAT_1002270c;
undefined DAT_10022708;
undefined DAT_10022704;
undefined DAT_10022730;
undefined DAT_10022724;
undefined DAT_10022700;
undefined DAT_100226fc;
undefined DAT_100226f8;
undefined DAT_100226f4;
undefined DAT_10022728;
undefined DAT_1002271c;
undefined4 DAT_10022720;
undefined DAT_1002272c;
undefined DAT_10022668;
undefined DAT_10022624;
undefined DAT_10022618;
undefined DAT_1002261c;
undefined DAT_10022628;
undefined4 DAT_1002208c;
undefined4 DAT_1002262c;
pointer PTR_DAT_10019708;
IMAGE_DOS_HEADER IMAGE_DOS_HEADER_10000000;
undefined FUN_10010feb;
uint DAT_1002208c;
undefined *PTR_vftable_10022000;
undefined *PTR_vftable_10022004;
undefined *PTR_vftable_10022008;
int *DAT_100225f0;

void * __thiscall FUN_100010d0(void *this,byte param_1)

{
  *(undefined ***)this = std::error_category::vftable;
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



undefined * __thiscall FUN_100010f0(void *this,uint param_1,size_t param_2)

{
  uint uVar1;
  uint uVar2;
  void *_Src;
  uint uVar3;
  uint uVar4;
  undefined *local_18;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  puStack_c = &LAB_100114c0;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
  uVar3 = param_1 | 0xf;
  uVar4 = param_1;
  if (uVar3 != 0xffffffff) {
    uVar1 = *(uint *)((int)this + 0x14);
    uVar2 = uVar1 >> 1;
    uVar4 = uVar3;
    if ((uVar3 / 3 < uVar2) && (uVar4 = uVar2 + uVar1, -uVar2 - 2 < uVar1)) {
      uVar4 = 0xfffffffe;
    }
  }
  local_8 = 0;
  local_18 = (undefined *)0x0;
  if ((uVar4 + 1 != 0) &&
     (local_18 = (undefined *)operator_new(uVar4 + 1), local_18 == (undefined *)0x0)) {
    std::_Xbad_alloc();
    local_8 = CONCAT31(local_8._1_3_,2);
    FUN_10001240(param_1 + 1);
    return &DAT_100011a6;
  }
  if (param_2 != 0) {
    _Src = this;
    if (0xf < *(uint *)((int)this + 0x14)) {
                    // WARNING: Load size is inaccurate
      _Src = *this;
    }
    if (param_2 != 0) {
      memcpy(local_18,_Src,param_2);
    }
  }
  if (0xf < *(uint *)((int)this + 0x14)) {
                    // WARNING: Load size is inaccurate
    operator_delete(*this);
  }
  *(undefined1 *)this = 0;
  *(undefined **)this = local_18;
  *(uint *)((int)this + 0x14) = uVar4;
  *(size_t *)((int)this + 0x10) = param_2;
  if (0xf < uVar4) {
    this = local_18;
  }
  *(undefined1 *)((int)this + param_2) = 0;
  ExceptionList = local_10;
  return local_18;
}



undefined * Catch_All_10001186(void)

{
  void *pvVar1;
  int unaff_EBP;
  
  *(int *)(unaff_EBP + -0x14) = *(int *)(unaff_EBP + 8);
  *(BADSPACEBASE **)(unaff_EBP + -0x10) = register0x00000010;
  *(undefined1 *)(unaff_EBP + -4) = 2;
  pvVar1 = FUN_10001240(*(int *)(unaff_EBP + 8) + 1);
  *(void **)(unaff_EBP + 8) = pvVar1;
  return &DAT_100011a6;
}



void Catch_All_100011c3(void)

{
  undefined4 *puVar1;
  int unaff_EBP;
  
  puVar1 = *(undefined4 **)(unaff_EBP + -0x18);
  if (0xf < (uint)puVar1[5]) {
    operator_delete((void *)*puVar1);
  }
  puVar1[5] = 0xf;
  puVar1[4] = 0;
  *(undefined1 *)puVar1 = 0;
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void * FUN_10001240(uint param_1)

{
  void *pvVar1;
  void *extraout_ECX;
  
  pvVar1 = (void *)0x0;
  if ((param_1 != 0) && (pvVar1 = operator_new(param_1), pvVar1 == (void *)0x0)) {
    std::_Xbad_alloc();
    pvVar1 = extraout_ECX;
  }
  return pvVar1;
}



void * __thiscall FUN_10001270(void *this,undefined4 *param_1,uint param_2)

{
  uint extraout_EAX;
  void *extraout_ECX;
  void *extraout_ECX_00;
  void *extraout_ECX_01;
  void *pvVar1;
  uint uVar2;
  
  uVar2 = param_1[4];
  pvVar1 = this;
  if (uVar2 < param_2) {
    std::_Xout_of_range("invalid string position");
    pvVar1 = extraout_ECX;
  }
  uVar2 = uVar2 - param_2;
  if (param_2 < uVar2) {
    uVar2 = param_2;
  }
  if ((undefined4 *)this == param_1) {
    uVar2 = uVar2 + param_2;
    if (*(uint *)((int)this + 0x10) < uVar2) {
      std::_Xout_of_range("invalid string position");
      uVar2 = extraout_EAX;
      pvVar1 = extraout_ECX_00;
    }
    *(uint *)((int)this + 0x10) = uVar2;
    if (0xf < *(uint *)((int)this + 0x14)) {
                    // WARNING: Load size is inaccurate
      pvVar1 = *this;
    }
    *(undefined1 *)((int)pvVar1 + uVar2) = 0;
    FUN_10001510(this,0);
    return this;
  }
  if (uVar2 == 0xffffffff) {
    std::_Xlength_error("string too long");
    pvVar1 = extraout_ECX_01;
  }
  if (*(uint *)((int)this + 0x14) < uVar2) {
    FUN_100010f0(pvVar1,uVar2,*(size_t *)((int)this + 0x10));
    if (uVar2 == 0) {
      return this;
    }
  }
  else if (uVar2 == 0) {
    *(undefined4 *)((int)this + 0x10) = 0;
    if (0xf < *(uint *)((int)this + 0x14)) {
                    // WARNING: Load size is inaccurate
      **this = 0;
      return this;
    }
    *(undefined1 *)this = 0;
    return this;
  }
  if (0xf < (uint)param_1[5]) {
    param_1 = (undefined4 *)*param_1;
  }
  pvVar1 = this;
  if (0xf < *(uint *)((int)this + 0x14)) {
                    // WARNING: Load size is inaccurate
    pvVar1 = *this;
  }
  if (uVar2 != 0) {
    memcpy(pvVar1,(void *)((int)param_1 + param_2),uVar2);
  }
  *(uint *)((int)this + 0x10) = uVar2;
  if (*(uint *)((int)this + 0x14) < 0x10) {
    *(undefined1 *)((int)this + uVar2) = 0;
    return this;
  }
                    // WARNING: Load size is inaccurate
  *(undefined1 *)(*this + uVar2) = 0;
  return this;
}



void * __thiscall FUN_10001370(void *this,void *param_1,uint param_2)

{
  uint uVar1;
  void *pvVar2;
  
  if (param_1 != (void *)0x0) {
    uVar1 = *(uint *)((int)this + 0x14);
    pvVar2 = this;
    if (0xf < uVar1) {
                    // WARNING: Load size is inaccurate
      pvVar2 = *this;
    }
    if (pvVar2 <= param_1) {
      pvVar2 = this;
      if (0xf < uVar1) {
                    // WARNING: Load size is inaccurate
        pvVar2 = *this;
      }
      if (param_1 < (void *)(*(int *)((int)this + 0x10) + (int)pvVar2)) {
        if (0xf < uVar1) {
                    // WARNING: Load size is inaccurate
          pvVar2 = FUN_10001270(this,(undefined4 *)this,(int)param_1 - *this);
          return pvVar2;
        }
        pvVar2 = FUN_10001270(this,(undefined4 *)this,(int)param_1 - (int)this);
        return pvVar2;
      }
    }
  }
  if (param_2 == 0xffffffff) {
    std::_Xlength_error("string too long");
  }
  if (*(uint *)((int)this + 0x14) < param_2) {
    FUN_100010f0(this,param_2,*(size_t *)((int)this + 0x10));
    if (param_2 == 0) {
      return this;
    }
  }
  else if (param_2 == 0) {
    *(undefined4 *)((int)this + 0x10) = 0;
    if (0xf < *(uint *)((int)this + 0x14)) {
                    // WARNING: Load size is inaccurate
      **this = 0;
      return this;
    }
    *(undefined1 *)this = 0;
    return this;
  }
  pvVar2 = this;
  if (0xf < *(uint *)((int)this + 0x14)) {
                    // WARNING: Load size is inaccurate
    pvVar2 = *this;
  }
  if (param_2 != 0) {
    memcpy(pvVar2,param_1,param_2);
  }
  *(uint *)((int)this + 0x10) = param_2;
  if (*(uint *)((int)this + 0x14) < 0x10) {
    *(undefined1 *)((int)this + param_2) = 0;
    return this;
  }
                    // WARNING: Load size is inaccurate
  *(undefined1 *)(*this + param_2) = 0;
  return this;
}



void FUN_10001470(int *param_1,int param_2)

{
  char *pcVar1;
  
  pcVar1 = std::_Syserror_map(param_2);
  *param_1 = param_2;
  if (pcVar1 != (char *)0x0) {
    param_1[1] = (int)&PTR_vftable_10022000;
    return;
  }
  param_1[1] = (int)&PTR_vftable_10022008;
  return;
}



void __thiscall FUN_100014a0(void *this,undefined4 *param_1,undefined4 param_2)

{
  *param_1 = param_2;
  param_1[1] = this;
  return;
}



uint __thiscall FUN_100014b0(void *this,int *param_1,int param_2)

{
  if ((this == (void *)param_1[1]) && (param_1 = (int *)*param_1, param_1 == (int *)param_2)) {
    return CONCAT31((int3)((uint)param_1 >> 8),1);
  }
  return (uint)param_1 & 0xffffff00;
}



uint __thiscall FUN_100014d0(void *this,undefined4 param_1)

{
  int *piVar1;
  int *unaff_retaddr;
  undefined1 local_8 [8];
  
                    // WARNING: Load size is inaccurate
  piVar1 = (int *)(**(code **)(*this + 0xc))(local_8,param_1);
  if ((piVar1[1] == unaff_retaddr[1]) && (piVar1 = (int *)*piVar1, piVar1 == (int *)*unaff_retaddr))
  {
    return CONCAT31((int3)((uint)piVar1 >> 8),1);
  }
  return (uint)piVar1 & 0xffffff00;
}



void * __thiscall FUN_10001510(void *this,uint param_1)

{
  uint uVar1;
  void *pvVar2;
  uint extraout_ECX;
  uint uVar3;
  int iVar4;
  
  uVar1 = *(uint *)((int)this + 0x10);
  uVar3 = param_1;
  if (uVar1 < param_1) {
    std::_Xout_of_range("invalid string position");
    uVar3 = extraout_ECX;
  }
  if (uVar1 - uVar3 <= param_1) {
    *(uint *)((int)this + 0x10) = uVar3;
    if (*(uint *)((int)this + 0x14) < 0x10) {
      *(undefined1 *)((int)this + uVar3) = 0;
      return this;
    }
                    // WARNING: Load size is inaccurate
    *(undefined1 *)(*this + uVar3) = 0;
    return this;
  }
  if (param_1 != 0) {
    pvVar2 = this;
    if (0xf < *(uint *)((int)this + 0x14)) {
                    // WARNING: Load size is inaccurate
      pvVar2 = *this;
    }
    iVar4 = uVar1 - param_1;
    if (iVar4 - uVar3 != 0) {
      memmove((void *)((int)pvVar2 + uVar3),(void *)((int)((int)pvVar2 + uVar3) + param_1),
              iVar4 - uVar3);
    }
    *(int *)((int)this + 0x10) = iVar4;
    if (0xf < *(uint *)((int)this + 0x14)) {
                    // WARNING: Load size is inaccurate
      *(undefined1 *)(*this + iVar4) = 0;
      return this;
    }
    *(undefined1 *)((int)this + iVar4) = 0;
  }
  return this;
}



undefined1 * FUN_100015b0(undefined1 *param_1,int param_2)

{
  char cVar1;
  char *pcVar2;
  char *pcVar3;
  
  pcVar2 = std::_Syserror_map(param_2);
  pcVar3 = "unknown error";
  if (pcVar2 != (char *)0x0) {
    pcVar3 = pcVar2;
  }
  *(undefined4 *)(param_1 + 0x14) = 0xf;
  *(undefined4 *)(param_1 + 0x10) = 0;
  *param_1 = 0;
  if (*pcVar3 == '\0') {
    FUN_10001370(param_1,pcVar3,0);
    return param_1;
  }
  pcVar2 = pcVar3;
  do {
    cVar1 = *pcVar2;
    pcVar2 = pcVar2 + 1;
  } while (cVar1 != '\0');
  FUN_10001370(param_1,pcVar3,(int)pcVar2 - (int)(pcVar3 + 1));
  return param_1;
}



undefined1 * FUN_10001620(undefined1 *param_1,int param_2)

{
  if (param_2 == 1) {
    *(undefined4 *)(param_1 + 0x14) = 0xf;
    *(undefined4 *)(param_1 + 0x10) = 0;
    *param_1 = 0;
    FUN_10001370(param_1,"iostream stream error",0x15);
    return param_1;
  }
  FUN_100015b0(param_1,param_2);
  return param_1;
}



undefined1 * FUN_10001670(undefined1 *param_1,int param_2)

{
  char cVar1;
  char *pcVar2;
  char *pcVar3;
  
  pcVar2 = std::_Winerror_map(param_2);
  pcVar3 = "unknown error";
  if (pcVar2 != (char *)0x0) {
    pcVar3 = pcVar2;
  }
  *(undefined4 *)(param_1 + 0x14) = 0xf;
  *(undefined4 *)(param_1 + 0x10) = 0;
  *param_1 = 0;
  if (*pcVar3 == '\0') {
    FUN_10001370(param_1,pcVar3,0);
    return param_1;
  }
  pcVar2 = pcVar3;
  do {
    cVar1 = *pcVar2;
    pcVar2 = pcVar2 + 1;
  } while (cVar1 != '\0');
  FUN_10001370(param_1,pcVar3,(int)pcVar2 - (int)(pcVar3 + 1));
  return param_1;
}



char * FUN_100016e0(void)

{
  return "generic";
}



char * FUN_100016f0(void)

{
  return "iostream";
}



char * FUN_10001700(void)

{
  return "system";
}



QObject * __cdecl CreateInterface(undefined4 param_1,undefined4 *param_2)

{
  QObject *pQVar1;
  
                    // 0x1710  1  CreateInterface
  if (param_2 != (undefined4 *)0x0) {
    *param_2 = 0;
  }
  pQVar1 = (QObject *)operator_new(0x68);
  if (pQVar1 != (QObject *)0x0) {
    pQVar1 = FUN_10003280(pQVar1);
    if (pQVar1 != (QObject *)0x0) {
      return pQVar1 + 8;
    }
  }
  return (QObject *)0x0;
}



int __cdecl FUN_10001740(int param_1)

{
  uint uVar1;
  
  if (param_1 < 0) {
    param_1 = 0;
  }
  uVar1 = param_1 - 1U | (int)(param_1 - 1U) >> 1;
  uVar1 = uVar1 | (int)uVar1 >> 2;
  uVar1 = uVar1 | (int)uVar1 >> 4;
  return ((int)uVar1 >> 8 | uVar1) + 1;
}



void * __thiscall FUN_10001770(void *this,QObject *param_1)

{
  ExternalRefCountData *this_00;
  
  *(QObject **)this = param_1;
  if (param_1 == (QObject *)0x0) {
    *(undefined4 *)((int)this + 4) = 0;
    return this;
  }
  this_00 = (ExternalRefCountData *)operator_new(0x10);
  if (this_00 + 0xc != (ExternalRefCountData *)0x0) {
    *(QObject **)(this_00 + 0xc) = param_1;
  }
  if (this_00 != (ExternalRefCountData *)0x0) {
    *(undefined1 **)(this_00 + 8) = &LAB_10001a30;
    *(undefined4 *)(this_00 + 4) = 1;
    *(undefined4 *)this_00 = 1;
  }
  *(ExternalRefCountData **)((int)this + 4) = this_00;
  QtSharedPointer::ExternalRefCountData::setQObjectShared(this_00,param_1,true);
  param_2_10003760();
  return this;
}



void * __thiscall FUN_100017e0(void *this,undefined4 *param_1)

{
  undefined4 uVar1;
  undefined4 uVar2;
  int *piVar3;
  int iVar4;
  
  uVar1 = *param_1;
  uVar2 = param_1[1];
  param_1[1] = 0;
  *param_1 = 0;
  piVar3 = *(int **)((int)this + 4);
  *(undefined4 *)((int)this + 4) = uVar2;
  *(undefined4 *)this = uVar1;
  if (piVar3 != (int *)0x0) {
    LOCK();
    iVar4 = piVar3[1] + -1;
    piVar3[1] = iVar4;
    UNLOCK();
    if (iVar4 == 0) {
      (*(code *)piVar3[2])(piVar3);
    }
    LOCK();
    iVar4 = *piVar3;
    *piVar3 = *piVar3 + -1;
    UNLOCK();
    if (iVar4 == 1) {
      operator_delete(piVar3);
    }
  }
  return this;
}



void * __thiscall FUN_10001840(void *this,byte param_1)

{
  QEvent::~QEvent((QEvent *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10001860(void *this,byte param_1)

{
  QOpenGLShaderProgram::~QOpenGLShaderProgram((QOpenGLShaderProgram *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void __fastcall FUN_10001880(int param_1)

{
  QMutex *local_4;
  
  local_4 = (QMutex *)(param_1 + 0x68);
  if (local_4 != (QMutex *)0x0) {
    QMutex::lock(local_4);
    local_4 = (QMutex *)((uint)local_4 | 1);
  }
  *(undefined1 *)(param_1 + 0x6c) = 1;
  QMutexLocker::unlock((QMutexLocker *)&local_4);
  return;
}



void __fastcall FUN_100018b0(int param_1)

{
  QOpenGLFunctions *this;
  QSurface *pQVar1;
  QThread *pQVar2;
  
  this = QOpenGLContext::functions(*(QOpenGLContext **)(param_1 + 0x10));
  if (*(int *)(param_1 + 0x14) == 0) {
    pQVar1 = (QSurface *)0x0;
  }
  else {
    pQVar1 = (QSurface *)(*(int *)(param_1 + 0x14) + 8);
  }
  QOpenGLContext::makeCurrent(*(QOpenGLContext **)(param_1 + 0x10),pQVar1);
  QQuickRenderControl::invalidate(*(QQuickRenderControl **)(param_1 + 0x1c));
  if (*(int *)(param_1 + 0x40) != 0) {
    QOpenGLFunctions::glBindFramebuffer(this,0x8d40,0);
    QOpenGLFunctions::glBindRenderbuffer(this,0x8d41,0);
    QOpenGLFunctions::glBindTexture(this,0xde1,0);
    QOpenGLFunctions::glDeleteTextures(this,1,(uint *)(param_1 + 0x30));
    QOpenGLFunctions::glDeleteRenderbuffers(this,1,(uint *)(param_1 + 0x38));
    QOpenGLFunctions::glDeleteFramebuffers(this,1,(uint *)(param_1 + 0x40));
    *(uint *)(param_1 + 0x30) = 0;
    *(uint *)(param_1 + 0x38) = 0;
    *(undefined4 *)(param_1 + 0x40) = 0;
  }
  if (*(int *)(param_1 + 0x44) != 0) {
    QOpenGLFunctions::glBindFramebuffer(this,0x8d40,0);
    QOpenGLFunctions::glBindRenderbuffer(this,0x8d41,0);
    QOpenGLFunctions::glBindTexture(this,0xde1,*(uint *)(param_1 + 0x34));
    Ordinal_21(*(undefined4 *)(param_1 + 0x50),*(undefined4 *)(param_1 + 0x58),0x3084);
    QOpenGLFunctions::glBindTexture(this,0xde1,0);
    QOpenGLFunctions::glDeleteTextures(this,1,(uint *)(param_1 + 0x34));
    Ordinal_12(*(undefined4 *)(param_1 + 0x50),*(undefined4 *)(param_1 + 0x58));
    QOpenGLFunctions::glDeleteRenderbuffers(this,1,(uint *)(param_1 + 0x3c));
    QOpenGLFunctions::glDeleteFramebuffers(this,1,(uint *)(param_1 + 0x44));
    *(undefined4 *)(param_1 + 0x58) = 0;
    *(uint *)(param_1 + 0x34) = 0;
    *(uint *)(param_1 + 0x3c) = 0;
    *(undefined4 *)(param_1 + 0x44) = 0;
  }
  QOpenGLContext::doneCurrent(*(QOpenGLContext **)(param_1 + 0x10));
  pQVar2 = QObject::thread(*(QObject **)self_exref);
  QObject::moveToThread(*(QObject **)(param_1 + 0x10),pQVar2);
                    // WARNING: Could not recover jumptable at 0x10001a21. Too many branches
                    // WARNING: Treating indirect jump as call
  QWaitCondition::wakeOne((QWaitCondition *)(param_1 + 8));
  return;
}



void __fastcall FUN_10001a50(int param_1)

{
  uint *puVar1;
  uint *puVar2;
  char cVar3;
  undefined4 uVar4;
  QOpenGLFunctions *this;
  char *pcVar5;
  QString *pQVar6;
  QMessageLogger *pQVar7;
  QDebug *pQVar8;
  undefined4 uVar9;
  int iVar10;
  char *pcVar11;
  int iVar12;
  undefined4 uStack_164;
  undefined1 **ppuStack_160;
  undefined4 uStack_15c;
  undefined4 uStack_158;
  undefined4 uStack_140;
  undefined1 *puStack_134;
  undefined4 uStack_130;
  undefined1 **ppuStack_12c;
  undefined4 uStack_128;
  undefined4 uStack_124;
  undefined4 uStack_120;
  undefined1 *puStack_11c;
  QTypedArrayData<> *pQStack_118;
  undefined1 *puStack_114;
  undefined4 uStack_110;
  undefined4 uStack_10c;
  undefined1 *puStack_fc;
  undefined1 *puStack_f8;
  undefined1 *puStack_d8;
  undefined1 *puStack_b8;
  QTypedArrayData<> *apQStack_88 [2];
  undefined1 uStack_80;
  undefined3 uStack_7f;
  undefined1 uStack_7c;
  QMessageLogger aQStack_78 [12];
  QString aQStack_6c [4];
  QString aQStack_68 [4];
  undefined4 uStack_64;
  QDebug aQStack_60 [20];
  undefined4 uStack_4c;
  undefined4 uStack_44;
  undefined1 uStack_40;
  undefined4 uStack_2c;
  int iStack_24;
  undefined1 uStack_20;
  uint local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100115ac;
  local_c = ExceptionList;
  local_10 = DAT_10022088 ^ (uint)apQStack_88;
  ExceptionList = &local_c;
  this = QOpenGLContext::functions(*(QOpenGLContext **)(param_1 + 0x10));
  if (*(int *)(param_1 + 0x20) != *(int *)(param_1 + 0x5c)) {
    if (*(int *)(param_1 + 0x44) != 0) {
      QOpenGLFunctions::glBindFramebuffer(this,0x8d40,0);
      QOpenGLFunctions::glBindRenderbuffer(this,0x8d41,0);
      QOpenGLFunctions::glBindTexture(this,0xde1,*(uint *)(param_1 + 0x34));
      Ordinal_21();
      QOpenGLFunctions::glBindTexture(this,0xde1,0);
      QOpenGLFunctions::glDeleteTextures(this,1,(uint *)(param_1 + 0x34));
      Ordinal_12();
      QOpenGLFunctions::glDeleteRenderbuffers(this,1,(uint *)(param_1 + 0x3c));
      QOpenGLFunctions::glDeleteFramebuffers(this,1,(uint *)(param_1 + 0x44));
      *(undefined4 *)(param_1 + 0x58) = 0;
      *(uint *)(param_1 + 0x34) = 0;
      *(uint *)(param_1 + 0x3c) = 0;
      *(undefined4 *)(param_1 + 0x44) = 0;
    }
    pcVar5 = (char *)Ordinal_5();
    if (pcVar5 == (char *)0x0) {
      iVar12 = -1;
    }
    else {
      pcVar11 = pcVar5;
      do {
        cVar3 = *pcVar11;
        pcVar11 = pcVar11 + 1;
      } while (cVar3 != '\0');
      iVar12 = (int)pcVar11 - (int)(pcVar5 + 1);
    }
    QString::fromAscii_helper(pcVar5,iVar12);
    local_c = (void *)0x0;
    puStack_b8 = (undefined1 *)0x10001b91;
    apQStack_88[0] = QString::fromAscii_helper("EGL Vendor: %1",0xe);
    _uStack_80 = CONCAT31(uStack_7f,0x20);
    local_c = (void *)CONCAT31(local_c._1_3_,1);
    QChar::QChar((QChar *)&stack0xffffff58);
    puStack_b8 = &stack0xffffff70;
    pQVar6 = (QString *)QString::arg((QString *)&stack0xffffff74);
    uStack_20 = 2;
    pQVar7 = (QMessageLogger *)QMessageLogger::QMessageLogger(aQStack_78,(char *)0x0,0,(char *)0x0);
    pQVar8 = (QDebug *)QMessageLogger::debug(pQVar7);
    iStack_24._0_1_ = 3;
    QDebug::operator<<(pQVar8,pQVar6);
    iStack_24._0_1_ = 2;
    QDebug::~QDebug((QDebug *)&stack0xffffff6c);
    iStack_24._0_1_ = 1;
    QString::~QString((QString *)&stack0xffffff5c);
    iStack_24 = (uint)iStack_24._1_3_ << 8;
    QString::~QString((QString *)&stack0xffffff60);
    iStack_24 = 0xffffffff;
    QString::~QString((QString *)&stack0xffffff58);
    pcVar5 = (char *)Ordinal_5();
    if (pcVar5 == (char *)0x0) {
      iVar12 = -1;
    }
    else {
      pcVar11 = pcVar5;
      do {
        cVar3 = *pcVar11;
        pcVar11 = pcVar11 + 1;
      } while (cVar3 != '\0');
      iVar12 = (int)pcVar11 - (int)(pcVar5 + 1);
    }
    QString::fromAscii_helper(pcVar5,iVar12);
    uStack_2c = 4;
    puStack_d8 = (undefined1 *)0x10001c8d;
    QString::fromAscii_helper("EGL Version: %1",0xf);
    uStack_2c = CONCAT31(uStack_2c._1_3_,5);
    QChar::QChar((QChar *)&stack0xffffff38);
    puStack_d8 = &stack0xffffff5c;
    pQVar6 = (QString *)QString::arg((QString *)&stack0xffffff4c);
    uStack_40 = 6;
    pQVar7 = (QMessageLogger *)
             QMessageLogger::QMessageLogger
                       ((QMessageLogger *)&stack0xffffff68,(char *)0x0,0,(char *)0x0);
    pQVar8 = (QDebug *)QMessageLogger::debug(pQVar7);
    uStack_44._0_1_ = (QMessageLogger)0x7;
    QDebug::operator<<(pQVar8,pQVar6);
    uStack_44._0_1_ = (QMessageLogger)0x6;
    QDebug::~QDebug((QDebug *)&stack0xffffff4c);
    uStack_44._0_1_ = (QMessageLogger)0x5;
    QString::~QString((QString *)&puStack_b8);
    uStack_44 = CONCAT31(uStack_44._1_3_,4);
    QString::~QString((QString *)&stack0xffffff38);
    uStack_44 = 0xffffffff;
    QString::~QString((QString *)&stack0xffffff40);
    pcVar5 = (char *)Ordinal_5();
    if (pcVar5 == (char *)0x0) {
      iVar12 = -1;
    }
    else {
      pcVar11 = pcVar5;
      do {
        cVar3 = *pcVar11;
        pcVar11 = pcVar11 + 1;
      } while (cVar3 != '\0');
      iVar12 = (int)pcVar11 - (int)(pcVar5 + 1);
    }
    QString::fromAscii_helper(pcVar5,iVar12);
    uStack_4c = 8;
    puStack_f8 = (undefined1 *)0x10001d8a;
    QString::fromAscii_helper("EGL Extensions: %1",0x12);
    uStack_4c = CONCAT31(uStack_4c._1_3_,9);
    QChar::QChar((QChar *)&stack0xffffff18);
    puStack_f8 = &stack0xffffff3c;
    puStack_fc = (undefined1 *)0x10001dc0;
    pQVar6 = (QString *)QString::arg((QString *)&stack0xffffff2c);
    puStack_fc = &stack0xffffff30;
    aQStack_60[0] = (QDebug)0xa;
    uStack_10c = 0x10001ddf;
    pQVar7 = (QMessageLogger *)
             QMessageLogger::QMessageLogger((QMessageLogger *)&puStack_b8,(char *)0x0,0,(char *)0x0)
    ;
    pQVar8 = (QDebug *)QMessageLogger::debug(pQVar7);
    uStack_64._0_1_ = (QString)0xb;
    QDebug::operator<<(pQVar8,pQVar6);
    uStack_64._0_1_ = (QString)0xa;
    QDebug::~QDebug((QDebug *)&stack0xffffff2c);
    uStack_64._0_1_ = (QString)0x9;
    QString::~QString((QString *)&puStack_d8);
    uStack_64 = CONCAT31(uStack_64._1_3_,8);
    QString::~QString((QString *)&stack0xffffff18);
    uStack_64 = 0xffffffff;
    QString::~QString((QString *)&stack0xffffff20);
    QString::fromAscii_helper
              ("m_eglClientBuffer = 0x%1, m_renderTargetWidth = %2, m_renderTargetHeight = %3",0x4d)
    ;
    uStack_64 = 0xc;
    QChar::QChar((QChar *)&stack0xffffff00);
    uStack_10c = 0;
    uStack_110 = *(undefined4 *)(param_1 + 0x20);
    puStack_114 = &stack0xffffff20;
    pQStack_118 = (QTypedArrayData<> *)0x10001e85;
    pQVar6 = (QString *)QString::arg((QString *)&stack0xffffff14);
    puStack_fc = (undefined1 *)CONCAT31(puStack_fc._1_3_,0x20);
    puStack_11c = puStack_fc;
    uStack_7c = 0xd;
    uStack_120 = 0x10001ea1;
    QChar::QChar((QChar *)&pQStack_118);
    uStack_120 = 10;
    uStack_124 = 0;
    uStack_128 = *(undefined4 *)(param_1 + 0x24);
    ppuStack_12c = &puStack_fc;
    uStack_130 = 0x10001eb5;
    pQVar6 = (QString *)QString::arg(pQVar6);
    puStack_114 = (undefined1 *)CONCAT31(puStack_114._1_3_,0x20);
    puStack_134 = puStack_114;
    QChar::QChar((QChar *)&uStack_130);
    uVar4 = *(undefined4 *)(param_1 + 0x28);
    pQVar6 = (QString *)QString::arg(pQVar6);
    uStack_158 = 0x10001f04;
    pQVar7 = (QMessageLogger *)
             QMessageLogger::QMessageLogger
                       ((QMessageLogger *)&stack0xfffffefc,(char *)0x0,0,(char *)0x0);
    pQVar8 = (QDebug *)QMessageLogger::debug(pQVar7);
    QDebug::operator<<(pQVar8,pQVar6);
    QDebug::~QDebug((QDebug *)&uStack_120);
    QString::~QString((QString *)&uStack_124);
    QString::~QString((QString *)&ppuStack_12c);
    QString::~QString((QString *)&uStack_128);
    QString::~QString((QString *)&puStack_134);
    FUN_10001740(*(int *)(param_1 + 0x24));
    puStack_d8 = (undefined1 *)0x3056;
    FUN_10001740(*(int *)(param_1 + 0x28));
    if (*(int *)(param_1 + 0x20) != 0) {
      uStack_158 = 0x3200;
      uStack_15c = *(undefined4 *)(param_1 + 0x50);
      ppuStack_160 = (undefined1 **)0x10001fdc;
      uVar9 = Ordinal_18();
      *(undefined4 *)(param_1 + 0x58) = uVar9;
    }
    uVar9 = Ordinal_1();
    pQStack_118 = QString::fromAscii_helper("eglErrorValue = 0x%1, m_eglSurface = 0x%2",0x29);
    uStack_128 = CONCAT31(uStack_128._1_3_,0x20);
    QChar::QChar((QChar *)&stack0xfffffeb4);
    uStack_158 = 0;
    ppuStack_160 = &puStack_114;
    uStack_164 = 0x10002027;
    uStack_15c = uVar9;
    pQVar6 = (QString *)QString::arg((QString *)&puStack_11c);
    uStack_140 = CONCAT31((int3)((uint)uVar4 >> 8),0x20);
    QChar::QChar((QChar *)&uStack_164,uStack_140);
    pQVar6 = (QString *)QString::arg(pQVar6,&uStack_130,*(undefined4 *)(param_1 + 0x58),0,0x10);
    pQVar7 = (QMessageLogger *)
             QMessageLogger::QMessageLogger((QMessageLogger *)&uStack_44,(char *)0x0,0,(char *)0x0);
    pQVar8 = (QDebug *)QMessageLogger::debug(pQVar7);
    uStack_4._0_1_ = 0x14;
    QDebug::operator<<(pQVar8,pQVar6);
    uStack_4._0_1_ = 0x13;
    QDebug::~QDebug(aQStack_60);
    uStack_4._0_1_ = 0x12;
    QString::~QString(aQStack_68);
    uStack_4 = CONCAT31(uStack_4._1_3_,0x11);
    QString::~QString((QString *)&uStack_64);
    uStack_4 = 0xffffffff;
    QString::~QString(aQStack_6c);
    if (*(int *)(param_1 + 0x58) != 0) {
      puVar1 = (uint *)(param_1 + 0x34);
      QOpenGLFunctions::glGenTextures(this,1,puVar1);
      puVar2 = (uint *)(param_1 + 0x3c);
      QOpenGLFunctions::glGenRenderbuffers(this,1,puVar2);
      QOpenGLFunctions::glGenFramebuffers(this,1,(uint *)(param_1 + 0x44));
      QOpenGLFunctions::glBindTexture(this,0xde1,*puVar1);
      QOpenGLFunctions::glTexParameteri(this,0xde1,0x2802,0x2901);
      QOpenGLFunctions::glTexParameteri(this,0xde1,0x2803,0x2901);
      QOpenGLFunctions::glTexParameteri(this,0xde1,0x2801,0x2600);
      QOpenGLFunctions::glTexParameteri(this,0xde1,0x2800,0x2600);
      Ordinal_20();
      QOpenGLFunctions::glBindTexture(this,0xde1,0);
      QOpenGLFunctions::glBindRenderbuffer(this,0x8d41,*puVar2);
      iVar12 = FUN_10001740(*(int *)(param_1 + 0x28));
      iVar10 = FUN_10001740(*(int *)(param_1 + 0x24));
      QOpenGLFunctions::glRenderbufferStorage(this,0x8d41,0x88f0,iVar10,iVar12);
      QOpenGLFunctions::glBindRenderbuffer(this,0x8d41,0);
      QOpenGLFunctions::glBindFramebuffer(this,0x8d40,*(uint *)(param_1 + 0x44));
      QOpenGLFunctions::glFramebufferTexture2D(this,0x8d40,0x8ce0,0xde1,*puVar1,0);
      QOpenGLFunctions::glFramebufferRenderbuffer(this,0x8d40,0x8d00,0x8d41,*puVar2);
      QOpenGLFunctions::glFramebufferRenderbuffer(this,0x8d40,0x8d20,0x8d41,*puVar2);
      QOpenGLFunctions::glBindFramebuffer(this,0x8d40,0);
    }
    *(undefined4 *)(param_1 + 0x5c) = *(undefined4 *)(param_1 + 0x20);
  }
  ExceptionList = local_c;
  FUN_10010b2e(local_10 ^ (uint)apQStack_88);
  return;
}



uint __fastcall FUN_10002280(int param_1)

{
  uint *puVar1;
  uint *puVar2;
  QOpenGLFunctions *this;
  int iVar3;
  int iVar4;
  int iVar5;
  uint uVar6;
  uint uVar7;
  void *pvVar8;
  int iStack_8;
  int iStack_4;
  
  this = QOpenGLContext::functions(*(QOpenGLContext **)(param_1 + 0x10));
  uVar6 = CONCAT31((int3)((uint)this >> 8),1);
  if ((*(int *)(param_1 + 0x24) != *(int *)(param_1 + 0x60)) ||
     (*(int *)(param_1 + 0x28) != *(int *)(param_1 + 100))) {
    if (*(int *)(param_1 + 0x40) != 0) {
      QOpenGLFunctions::glBindFramebuffer(this,0x8d40,0);
      QOpenGLFunctions::glBindRenderbuffer(this,0x8d41,0);
      QOpenGLFunctions::glBindTexture(this,0xde1,0);
      QOpenGLFunctions::glDeleteTextures(this,1,(uint *)(param_1 + 0x30));
      QOpenGLFunctions::glDeleteRenderbuffers(this,1,(uint *)(param_1 + 0x38));
      QOpenGLFunctions::glDeleteFramebuffers(this,1,(uint *)(param_1 + 0x40));
      *(uint *)(param_1 + 0x30) = 0;
      *(uint *)(param_1 + 0x38) = 0;
      *(undefined4 *)(param_1 + 0x40) = 0;
    }
    puVar1 = (uint *)(param_1 + 0x30);
    QOpenGLFunctions::glGenTextures(this,1,puVar1);
    puVar2 = (uint *)(param_1 + 0x38);
    QOpenGLFunctions::glGenRenderbuffers(this,1,puVar2);
    QOpenGLFunctions::glGenFramebuffers(this,1,(uint *)(param_1 + 0x40));
    QOpenGLFunctions::glBindTexture(this,0xde1,*puVar1);
    QOpenGLFunctions::glTexParameteri(this,0xde1,0x2802,0x2901);
    QOpenGLFunctions::glTexParameteri(this,0xde1,0x2803,0x2901);
    QOpenGLFunctions::glTexParameteri(this,0xde1,0x2801,0x2600);
    QOpenGLFunctions::glTexParameteri(this,0xde1,0x2800,0x2600);
    pvVar8 = (void *)0x0;
    uVar7 = 0x1401;
    uVar6 = 0x1908;
    iVar5 = 0;
    iVar3 = FUN_10001740(*(int *)(param_1 + 0x28));
    iVar4 = FUN_10001740(*(int *)(param_1 + 0x24));
    QOpenGLFunctions::glTexImage2D(this,0xde1,0,0x1908,iVar4,iVar3,iVar5,uVar6,uVar7,pvVar8);
    QOpenGLFunctions::glBindTexture(this,0xde1,0);
    QOpenGLFunctions::glBindRenderbuffer(this,0x8d41,*puVar2);
    iVar3 = FUN_10001740(*(int *)(param_1 + 0x28));
    iVar4 = FUN_10001740(*(int *)(param_1 + 0x24));
    QOpenGLFunctions::glRenderbufferStorage(this,0x8d41,0x88f0,iVar4,iVar3);
    QOpenGLFunctions::glBindRenderbuffer(this,0x8d41,0);
    QOpenGLFunctions::glBindFramebuffer(this,0x8d40,*(uint *)(param_1 + 0x40));
    QOpenGLFunctions::glFramebufferTexture2D(this,0x8d40,0x8ce0,0xde1,*puVar1,0);
    QOpenGLFunctions::glFramebufferRenderbuffer(this,0x8d40,0x8d00,0x8d41,*puVar2);
    QOpenGLFunctions::glFramebufferRenderbuffer(this,0x8d40,0x8d20,0x8d41,*puVar2);
    QOpenGLFunctions::glClear(this,0x4500);
    QOpenGLFunctions::glBindFramebuffer(this,0x8d40,0);
    iVar3 = FUN_10001740(*(int *)(param_1 + 0x28));
    iStack_8 = FUN_10001740(*(int *)(param_1 + 0x24));
    iStack_4 = iVar3;
    QQuickWindow::setRenderTarget
              (*(QQuickWindow **)(param_1 + 0x18),*(uint *)(param_1 + 0x40),(QSize *)&iStack_8);
    *(undefined4 *)(param_1 + 0x60) = *(undefined4 *)(param_1 + 0x24);
    *(uint *)(param_1 + 100) = *(uint *)(param_1 + 0x28);
    uVar6 = *(uint *)(param_1 + 0x28) & 0xffffff00;
  }
  return uVar6;
}



bool __thiscall FUN_10002500(void *this,QEvent *param_1)

{
  short sVar1;
  bool bVar2;
  QSurface *pQVar3;
  QMutex *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_100115e9;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_10 = (QMutex *)((int)this + 0xc);
  if (local_10 != (QMutex *)0x0) {
    QMutex::lock(local_10);
    local_10 = (QMutex *)((uint)local_10 | 1);
  }
  local_4 = 0;
  sVar1 = *(short *)(param_1 + 8);
  if (sVar1 == 0x3e9) {
    if (*(int *)((int)this + 0x14) == 0) {
      pQVar3 = (QSurface *)0x0;
    }
    else {
      pQVar3 = (QSurface *)(*(int *)((int)this + 0x14) + 8);
    }
    QOpenGLContext::makeCurrent(*(QOpenGLContext **)((int)this + 0x10),pQVar3);
    QQuickRenderControl::initialize
              (*(QQuickRenderControl **)((int)this + 0x1c),*(QOpenGLContext **)((int)this + 0x10));
  }
  else if (sVar1 == 0x3ea) {
    FUN_100025d0(this,(uint *)&local_10);
  }
  else {
    if (sVar1 != 0x3eb) {
      bVar2 = QObject::event((QObject *)this,param_1);
      goto LAB_100025a2;
    }
    FUN_100018b0((int)this);
  }
  bVar2 = true;
LAB_100025a2:
  QMutexLocker::unlock((QMutexLocker *)&local_10);
  ExceptionList = local_c;
  return bVar2;
}



void __thiscall FUN_100025d0(void *this,uint *param_1)

{
  uint uVar1;
  uint uVar2;
  QOpenGLFunctions *this_00;
  bool bVar3;
  uint namelen;
  QMessageLogger *this_01;
  QDebug *this_02;
  QOpenGLShaderProgram *pQVar4;
  undefined4 *puVar5;
  QPlatformNativeInterface *pQVar6;
  undefined4 uVar7;
  int iVar8;
  uint uVar9;
  int iVar10;
  int iVar11;
  byte bVar12;
  QSurface *pQVar13;
  QTypedArrayData<> **ppQVar14;
  QMutex *this_03;
  uint uVar15;
  QTypedArrayData<> *pQVar16;
  __int64 _Var17;
  double dVar18;
  double dVar19;
  SOCKET s;
  sockaddr *addr;
  QByteArray aQStack_d8 [8];
  QString aQStack_d0 [4];
  void *pvStack_cc;
  QTypedArrayData<> *pQStack_c8;
  QMutex *local_c4;
  undefined8 uStack_c0;
  undefined8 uStack_b8;
  QTypedArrayData<> *pQStack_b0;
  QOpenGLFunctions *pQStack_ac;
  undefined8 uStack_a8;
  QOpenGLShaderProgram *pQStack_a0;
  QMessageLogger aQStack_94 [56];
  undefined4 uStack_5c;
  void *pvStack_54;
  void *pvStack_50;
  void *local_4c;
  undefined1 *puStack_48;
  undefined4 uStack_44;
  
  uStack_44 = 0xffffffff;
  puStack_48 = &LAB_10011651;
  local_4c = ExceptionList;
  namelen = DAT_10022088 ^ (uint)&stack0xffffff00;
  ExceptionList = &local_4c;
  local_c4 = (QMutex *)this;
  pQStack_ac = QOpenGLContext::functions(*(QOpenGLContext **)((int)this + 0x10));
  if (DAT_1002200c != '\0') {
    if (*(int *)((int)this + 0x14) == 0) {
      pQVar13 = (QSurface *)0x0;
    }
    else {
      pQVar13 = (QSurface *)(*(int *)((int)this + 0x14) + 8);
    }
    bVar3 = QOpenGLContext::makeCurrent(*(QOpenGLContext **)((int)this + 0x10),pQVar13);
    if (!bVar3) {
      uStack_c0._0_4_ =
           QString::fromAscii_helper("Failed To Make Context Current On Render Thread",0x2f);
      uStack_44 = 0;
      this_01 = (QMessageLogger *)
                QMessageLogger::QMessageLogger(aQStack_94,(char *)0x0,0,(char *)0x0);
      this_02 = (QDebug *)QMessageLogger::warning(this_01);
      puStack_48._0_1_ = 1;
      QDebug::operator<<(this_02,(QString *)&local_c4);
      puStack_48 = (undefined1 *)((uint)puStack_48._1_3_ << 8);
      QDebug::~QDebug((QDebug *)&pQStack_b0);
      puStack_48 = (undefined1 *)0xffffffff;
      QString::~QString((QString *)&local_c4);
      ExceptionList = pvStack_50;
      return;
    }
    pQVar4 = (QOpenGLShaderProgram *)operator_new(8);
    uStack_44 = 2;
    pQStack_a0 = pQVar4;
    if (pQVar4 == (QOpenGLShaderProgram *)0x0) {
      pQVar4 = (QOpenGLShaderProgram *)0x0;
    }
    else {
      QOpenGLShaderProgram::QOpenGLShaderProgram(pQVar4,(QObject *)0x0);
      *(undefined ***)pQVar4 = QOpenGLShaderProgram::vftable;
    }
    uStack_44 = 0xffffffff;
    puVar5 = (undefined4 *)FUN_10001770((void *)((int)&uStack_b8 + 4),(QObject *)pQVar4);
    FUN_100017e0((void *)((int)this + 0x48),puVar5);
    pQVar16 = pQStack_b0;
    if (pQStack_b0 != (QTypedArrayData<> *)0x0) {
      LOCK();
      iVar8 = *(int *)(pQStack_b0 + 4) + -1;
      *(int *)(pQStack_b0 + 4) = iVar8;
      UNLOCK();
      if (iVar8 == 0) {
        (**(code **)(pQStack_b0 + 8))(pQStack_b0);
      }
      LOCK();
      iVar8 = *(int *)pQVar16;
      *(int *)pQVar16 = *(int *)pQVar16 + -1;
      UNLOCK();
      if (iVar8 == 1) {
        operator_delete(pQVar16);
      }
    }
    uStack_c0._0_4_ = QString::fromAscii_helper(":/GLSL/BlitFrameBufferVertexShader.glsl",0x27);
    uStack_44 = 3;
    QOpenGLShaderProgram::addCacheableShaderFromSourceFile
              (*(QOpenGLShaderProgram **)((int)this + 0x48),1,&uStack_c0);
    local_4c = (void *)0xffffffff;
    QString::~QString((QString *)&pQStack_c8);
    pQStack_c8 = QString::fromAscii_helper(":/GLSL/BlitFrameBufferFragmentShader.glsl",0x29);
    local_4c = (void *)0x4;
    QOpenGLShaderProgram::addCacheableShaderFromSourceFile
              (*(QOpenGLShaderProgram **)((int)this + 0x48),2);
    pvStack_54 = (void *)0xffffffff;
    QString::~QString(aQStack_d0);
    QOpenGLShaderProgram::bindAttributeLocation
              (*(QOpenGLShaderProgram **)((int)this + 0x48),"attributePosition",0);
    QOpenGLShaderProgram::bindAttributeLocation
              (*(QOpenGLShaderProgram **)((int)this + 0x48),"attributeUV",1);
    (**(code **)(**(int **)((int)this + 0x48) + 0x2c))();
    pQVar6 = QGuiApplication::platformNativeInterface();
    QByteArray::QByteArray((QByteArray *)aQStack_d0,"eglDisplay",-1);
    pvStack_54 = (void *)0x5;
    uVar7 = (**(code **)(*(int *)pQVar6 + 0x30))(aQStack_d0,*(undefined4 *)((int)this + 0x10));
    *(undefined4 *)((int)this + 0x50) = uVar7;
    uStack_5c = 0xffffffff;
    QByteArray::~QByteArray(aQStack_d8);
    QByteArray::QByteArray(aQStack_d8,"eglConfig",-1);
    uStack_5c = 6;
    uVar7 = (**(code **)(*(int *)pQVar6 + 0x30))(aQStack_d8,*(undefined4 *)((int)this + 0x10));
    *(undefined4 *)((int)this + 0x54) = uVar7;
    uStack_44 = 0xffffffff;
    QByteArray::~QByteArray((QByteArray *)&uStack_c0);
    DAT_1002200c = '\0';
  }
  FUN_10002280((int)this);
  QQuickRenderControl::sync(*(QQuickRenderControl **)((int)this + 0x1c));
  QWaitCondition::wakeOne((QWaitCondition *)((int)this + 8));
  QQuickRenderControl::render(*(QQuickRenderControl **)((int)this + 0x1c));
  QOpenGLFunctions::glFinish(pQStack_ac);
  uStack_b8 = QDateTime::currentMSecsSinceEpoch();
  pQVar16 = (QTypedArrayData<> *)0x0;
  addr = (sockaddr *)0x0;
  s = 0x21d;
  uStack_c0._0_4_ = (QTypedArrayData<> *)0x0;
  iVar8 = (**(code **)(**(int **)((int)this + 0x2c) + 0x1c))();
  if (iVar8 != 0) {
    pQStack_b0 = (QTypedArrayData<> *)0xffff;
    uStack_a8 = (double)CONCAT44(uStack_a8._4_4_,1);
    do {
      while( true ) {
        _Var17 = QDateTime::currentMSecsSinceEpoch();
        uVar15 = (uint)_Var17 - (int)(QTypedArrayData<> *)uStack_c0;
        uVar1 = (uint)((uint)_Var17 < (QTypedArrayData<> *)uStack_c0);
        uVar2 = (int)((ulonglong)_Var17 >> 0x20) - uStack_c0._4_4_;
        iVar8 = uVar2 - uVar1;
        ppQVar14 = &pQStack_b0;
        if (pQVar16 < (QTypedArrayData<> *)0x10000) {
          ppQVar14 = &pQStack_c8;
        }
        uVar9 = 0x10000 - (int)*ppQVar14;
        if (uVar9 == 0) {
          bVar12 = 0;
        }
        else {
          iVar10 = 0x1f;
          if (uVar9 != 0) {
            for (; uVar9 >> iVar10 == 0; iVar10 = iVar10 + -1) {
            }
          }
          bVar12 = (byte)iVar10 ^ 0x1f;
        }
        pQStack_c8 = (QTypedArrayData<> *)((uint)(1 << ((bVar12 ^ 0x1f) & 0x1f)) >> 1);
        ppQVar14 = &pQStack_c8;
        if (pQStack_c8 < (QTypedArrayData<> *)0x2) {
          ppQVar14 = (QTypedArrayData<> **)&uStack_a8;
        }
        if ((uint)pQVar16 % (uint)*ppQVar14 == 0) {
          QThread::usleep(0);
        }
        pQVar16 = pQVar16 + 1;
        pQStack_c8 = pQVar16;
        iVar10 = (**(code **)(**(int **)((int)pvStack_cc + 0x2c) + 0x20))();
        this = pvStack_cc;
        if (iVar10 == 0) break;
        if ((0 < iVar8) || ((-1 < iVar8 && (199 < uVar15)))) goto LAB_100029a8;
      }
      if ((uVar2 != uVar1 && -1 < iVar8) || ((-1 < iVar8 && (199 < uVar15)))) goto LAB_100029a8;
      _Var17 = QDateTime::currentMSecsSinceEpoch();
      this = pvStack_cc;
      pQVar16 = (QTypedArrayData<> *)0x0;
      pQStack_c8 = (QTypedArrayData<> *)0x0;
      uStack_c0 = _Var17;
      iVar8 = (**(code **)(**(int **)((int)pvStack_cc + 0x2c) + 0x1c))(0x21d);
    } while (iVar8 != 0);
  }
  FUN_10001a50((int)this);
  pQStack_c8 = (QTypedArrayData<> *)(float)*(int *)((int)this + 0x28);
  iVar10 = FUN_10001740(*(int *)((int)this + 0x28));
  iVar8 = *(int *)((int)this + 0x24);
  pQStack_c8 = (QTypedArrayData<> *)((float)pQStack_c8 / (float)iVar10);
  iVar10 = FUN_10001740(iVar8);
  uStack_a8 = (double)(((float)iVar8 / (float)iVar10) * 256.0);
  dVar18 = ceil(uStack_a8);
  uStack_a8 = (double)((float)pQStack_c8 * 256.0);
  dVar19 = ceil(uStack_a8);
  this_00 = uStack_b8._4_4_;
  pQStack_b0 = (QTypedArrayData<> *)((float)(int)dVar18 * 0.00390625);
  pQStack_ac = (QOpenGLFunctions *)((float)(int)dVar19 * 0.00390625);
  uStack_a8 = (double)CONCAT44(pQStack_ac,pQStack_b0);
  QOpenGLFunctions::glBindFramebuffer(uStack_b8._4_4_,0x8d40,*(uint *)((int)this + 0x44));
  iVar8 = *(int *)((int)this + 0x28);
  iVar10 = *(int *)((int)this + 0x24);
  iVar11 = FUN_10001740(iVar8);
  QOpenGLFunctions::glViewport(this_00,0,iVar11 - *(int *)((int)this + 0x28),iVar10,iVar8);
  QOpenGLFunctions::glBindBuffer(this_00,0x8892,0);
  QOpenGLFunctions::glBindBuffer(this_00,0x8893,0);
  QOpenGLFunctions::glClear(this_00,0x4100);
  QOpenGLShaderProgram::bind(s,addr,namelen);
  QOpenGLShaderProgram::enableAttributeArray(*(QOpenGLShaderProgram **)((int)this + 0x48),0);
  QOpenGLShaderProgram::enableAttributeArray(*(QOpenGLShaderProgram **)((int)this + 0x48),1);
  QOpenGLShaderProgram::setAttributeArray
            (*(QOpenGLShaderProgram **)((int)this + 0x48),0,(float *)&DAT_100148c4,2,0);
  QOpenGLShaderProgram::setAttributeArray
            (*(QOpenGLShaderProgram **)((int)this + 0x48),1,(float *)&DAT_100148f4,2,0);
  QOpenGLFunctions::glBindTexture(this_00,0xde1,*(uint *)((int)this + 0x30));
  QOpenGLShaderProgram::setUniformValue
            (*(QOpenGLShaderProgram **)((int)this + 0x48),"textureSampler2D",0);
  QOpenGLShaderProgram::setUniformValue
            (*(QOpenGLShaderProgram **)((int)this + 0x48),"uvRegion",(QVector2D *)&pQStack_b0);
  QOpenGLFunctions::glDrawArrays(this_00,4,0,6);
  QOpenGLFunctions::glBindTexture(this_00,0xde1,0);
  QOpenGLShaderProgram::disableAttributeArray(*(QOpenGLShaderProgram **)((int)this + 0x48),0);
  QOpenGLShaderProgram::disableAttributeArray(*(QOpenGLShaderProgram **)((int)this + 0x48),1);
  QOpenGLShaderProgram::release(*(QOpenGLShaderProgram **)((int)this + 0x48));
  QOpenGLFunctions::glBindFramebuffer(this_00,0x8d40,0);
  QOpenGLFunctions::glFinish(this_00);
  (**(code **)(**(int **)((int)this + 0x2c) + 0x1c))(0,0x21d);
LAB_100029a8:
  if ((param_1 != (uint *)0x0) && ((*param_1 & 1) != 0)) {
    this_03 = (QMutex *)(*param_1 & 0xfffffffe);
    *param_1 = (uint)this_03;
    QMutex::unlock(this_03);
  }
  local_c4 = (QMutex *)((int)this + 0x68);
  if (local_c4 != (QMutex *)0x0) {
    QMutex::lock(local_c4);
    local_c4 = (QMutex *)((uint)local_c4 | 1);
  }
  QMutexLocker::unlock((QMutexLocker *)&local_c4);
  ExceptionList = pvStack_54;
  return;
}



void __fastcall FUN_10002c50(QObject *param_1)

{
  QEvent *this;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011eeb;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  this = (QEvent *)operator_new(0xc);
  local_4 = 0;
  if (this == (QEvent *)0x0) {
    this = (QEvent *)0x0;
  }
  else {
    QEvent::QEvent(this,0x3eb);
    *(undefined ***)this = QEvent::vftable;
  }
  local_4 = 0xffffffff;
  QCoreApplication::postEvent(param_1,this,0);
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_10002cd0(void *this,undefined4 param_1)

{
  QEvent *this_00;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_1001168b;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  *(undefined4 *)((int)this + 0x2c) = param_1;
  this_00 = (QEvent *)operator_new(0xc);
  local_4 = 0;
  if (this_00 == (QEvent *)0x0) {
    this_00 = (QEvent *)0x0;
  }
  else {
    QEvent::QEvent(this_00,0x3e9);
    *(undefined ***)this_00 = QEvent::vftable;
  }
  local_4 = 0xffffffff;
  QCoreApplication::postEvent((QObject *)this,this_00,0);
  ExceptionList = local_c;
  return;
}



void __fastcall FUN_10002d60(QObject *param_1)

{
  QEvent *this;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011eeb;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  this = (QEvent *)operator_new(0xc);
  local_4 = 0;
  if (this == (QEvent *)0x0) {
    this = (QEvent *)0x0;
  }
  else {
    QEvent::QEvent(this,0x3ea);
    *(undefined ***)this = QEvent::vftable;
  }
  local_4 = 0xffffffff;
  QCoreApplication::postEvent(param_1,this,0);
  ExceptionList = local_c;
  return;
}



// WARNING: Globals starting with '_' overlap smaller symbols at the same address

QObject * __cdecl
FUN_10002de0(QObject *param_1,void **param_2,undefined4 param_3,void **param_4,undefined4 param_5,
            undefined4 param_6,int *param_7)

{
  int *piVar1;
  undefined4 *puVar2;
  QMetaObject *pQVar3;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  piVar1 = param_7;
  puStack_8 = &LAB_100116be;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  pQVar3 = (QMetaObject *)0x0;
  if ((param_7 == (int *)0x2) || (param_7 == (int *)0x3)) {
    if ((DAT_100225e0 & 1) == 0) {
      DAT_100225e0 = DAT_100225e0 | 1;
      local_4 = 0;
      _DAT_100225d8 = FUN_10005b90();
      _DAT_100225dc = 0;
    }
    pQVar3 = (QMetaObject *)&DAT_100225d8;
  }
  local_4 = 0xffffffff;
  puVar2 = (undefined4 *)operator_new(0x10);
  if (puVar2 == (undefined4 *)0x0) {
    puVar2 = (undefined4 *)0x0;
  }
  else {
    *puVar2 = 1;
    puVar2[1] = &LAB_10004340;
    puVar2[2] = param_5;
    puVar2[3] = param_6;
  }
  QObject::connectImpl
            (param_1,param_2,(QObject *)&param_3,param_4,(QSlotObjectBase *)&param_5,
             (ConnectionType)puVar2,piVar1,pQVar3);
  ExceptionList = local_c;
  return param_1;
}



QObject * __cdecl
FUN_10002ec0(QObject *param_1,void **param_2,undefined4 param_3,void **param_4,undefined4 param_5,
            undefined4 param_6,int *param_7)

{
  undefined4 *puVar1;
  
  puVar1 = (undefined4 *)operator_new(0x10);
  if (puVar1 == (undefined4 *)0x0) {
    puVar1 = (undefined4 *)0x0;
  }
  else {
    *puVar1 = 1;
    puVar1[1] = &LAB_10004340;
    puVar1[2] = param_5;
    puVar1[3] = param_6;
  }
  QObject::connectImpl
            (param_1,param_2,(QObject *)&param_3,param_4,(QSlotObjectBase *)&param_5,
             (ConnectionType)puVar1,param_7,(QMetaObject *)0x0);
  return param_1;
}



QObject * __cdecl
FUN_10002f30(QObject *param_1,void **param_2,undefined4 param_3,void **param_4,undefined4 param_5,
            undefined4 param_6,int *param_7)

{
  undefined4 *puVar1;
  
  puVar1 = (undefined4 *)operator_new(0x10);
  if (puVar1 == (undefined4 *)0x0) {
    puVar1 = (undefined4 *)0x0;
  }
  else {
    *puVar1 = 1;
    puVar1[1] = &LAB_10004340;
    puVar1[2] = param_5;
    puVar1[3] = param_6;
  }
  QObject::connectImpl
            (param_1,param_2,(QObject *)&param_3,param_4,(QSlotObjectBase *)&param_5,
             (ConnectionType)puVar1,param_7,(QMetaObject *)0x0);
  return param_1;
}



void __cdecl FUN_10002fa0(QByteArray *param_1,int param_2,int param_3)

{
  int iVar1;
  undefined4 uVar2;
  
  if (param_2 == 0) {
    iVar1 = FUN_10005ad0();
    if (iVar1 != -1) {
      QMetaType::registerNormalizedTypedef(param_1,iVar1);
      return;
    }
  }
  uVar2 = 0xc;
  if (param_3 != 0) {
    uVar2 = 0x10c;
  }
  QMetaType::registerNormalizedType
            (param_1,param_2_10003760,param_3_10003ab0,4,uVar2,&param_6_10022070);
  return;
}


/*
Unable to decompile 'FUN_10003000'
Cause: 
Low-level Error: Forced merge caused intersection
*/


QObject * __fastcall FUN_10003280(QObject *param_1)

{
  QObject::QObject(param_1,(QObject *)0x0);
  *(undefined ***)(param_1 + 8) = IProxyExternalUI::vftable;
  *(undefined ***)param_1 = BlackMesaUIInstance::vftable;
  *(undefined ***)(param_1 + 8) = BlackMesaUIInstance::vftable;
  *(undefined4 *)(param_1 + 0xc) = 0;
  *(undefined4 *)(param_1 + 0x10) = 0;
  *(undefined4 *)(param_1 + 0x14) = 0;
  *(undefined4 *)(param_1 + 0x18) = 0;
  *(undefined4 *)(param_1 + 0x1c) = 0;
  *(undefined4 *)(param_1 + 0x20) = 0;
  *(undefined4 *)(param_1 + 0x24) = 0;
  *(undefined4 *)(param_1 + 0x28) = 0;
  *(undefined4 *)(param_1 + 0x2c) = 0;
  *(undefined4 *)(param_1 + 0x30) = 0;
  *(undefined4 *)(param_1 + 0x34) = 0;
  *(undefined4 *)(param_1 + 0x38) = 0;
  *(undefined4 *)(param_1 + 0x3c) = 0;
  *(undefined4 *)(param_1 + 0x40) = 0;
  *(undefined2 *)(param_1 + 0x44) = 0;
  *(undefined4 *)(param_1 + 0x48) = 0;
  *(undefined4 *)(param_1 + 0x4c) = 0;
  *(undefined4 *)(param_1 + 0x50) = 0;
  *(undefined4 *)(param_1 + 0x54) = 0;
  *(undefined4 *)(param_1 + 0x58) = 0;
  *(undefined4 *)(param_1 + 0x5c) = 0;
  *(undefined4 *)(param_1 + 0x60) = 0;
  *(undefined4 *)(param_1 + 100) = 0x1ffffff;
  return param_1;
}



QObject * __fastcall FUN_10003330(QObject *param_1)

{
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_1001174c;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  QObject::QObject(param_1,(QObject *)0x0);
  uStack_4 = 0;
  *(undefined ***)param_1 = BlackMesaUIRenderer::vftable;
  QWaitCondition::QWaitCondition((QWaitCondition *)(param_1 + 8));
  uStack_4._0_1_ = 1;
  QMutex::QMutex((QMutex *)(param_1 + 0xc),0);
  *(undefined4 *)(param_1 + 0x10) = 0;
  *(undefined4 *)(param_1 + 0x14) = 0;
  *(undefined4 *)(param_1 + 0x18) = 0;
  *(undefined4 *)(param_1 + 0x1c) = 0;
  *(undefined4 *)(param_1 + 0x20) = 0;
  *(undefined4 *)(param_1 + 0x24) = 0;
  *(undefined4 *)(param_1 + 0x28) = 0;
  *(undefined4 *)(param_1 + 0x2c) = 0;
  *(undefined4 *)(param_1 + 0x30) = 0;
  *(undefined4 *)(param_1 + 0x34) = 0;
  *(undefined4 *)(param_1 + 0x38) = 0;
  *(undefined4 *)(param_1 + 0x3c) = 0;
  *(undefined4 *)(param_1 + 0x40) = 0;
  *(undefined4 *)(param_1 + 0x44) = 0;
  *(undefined4 *)(param_1 + 0x48) = 0;
  *(undefined4 *)(param_1 + 0x4c) = 0;
  uStack_4 = CONCAT31(uStack_4._1_3_,3);
  *(undefined4 *)(param_1 + 0x50) = 0;
  *(undefined4 *)(param_1 + 0x54) = 0;
  *(undefined4 *)(param_1 + 0x58) = 0;
  *(undefined4 *)(param_1 + 0x5c) = 0;
  *(undefined4 *)(param_1 + 0x60) = 0;
  *(undefined4 *)(param_1 + 100) = 0;
  QMutex::QMutex((QMutex *)(param_1 + 0x68),0);
  param_1[0x6c] = (QObject)0x0;
  ExceptionList = local_c;
  return param_1;
}



void __fastcall FUN_10003450(undefined4 *param_1)

{
  int iVar1;
  int *piVar2;
  Data *pDVar3;
  Data *this;
  
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) {
      return;
    }
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  pDVar3 = (Data *)*param_1;
  iVar1 = *(int *)(pDVar3 + 8);
  this = pDVar3 + *(int *)(pDVar3 + 0xc) * 4 + 0x10;
  while (pDVar3 + iVar1 * 4 + 0x10 != this) {
    this = this + -4;
    QQmlError::~QQmlError((QQmlError *)this);
  }
  QListData::dispose(pDVar3);
  return;
}



void __fastcall FUN_100034b0(undefined4 *param_1)

{
  int iVar1;
  int *piVar2;
  QMapDataBase *this;
  
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) {
      return;
    }
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  this = (QMapDataBase *)*param_1;
  if (*(int *)(this + 0xc) != 0) {
    FUN_100041f0(*(int *)(this + 0xc));
    QMapDataBase::freeTree(this,*(QMapNodeBase **)(this + 0xc),8);
  }
  QMapDataBase::freeData(this);
  return;
}



void __fastcall FUN_10003500(int param_1)

{
  int *piVar1;
  int iVar2;
  
  piVar1 = *(int **)(param_1 + 4);
  if (piVar1 != (int *)0x0) {
    LOCK();
    iVar2 = piVar1[1] + -1;
    piVar1[1] = iVar2;
    UNLOCK();
    if (iVar2 == 0) {
      (*(code *)piVar1[2])(piVar1);
    }
    LOCK();
    iVar2 = *piVar1;
    *piVar1 = *piVar1 + -1;
    UNLOCK();
    if (iVar2 == 1) {
      operator_delete(piVar1);
    }
  }
  return;
}



void __fastcall FUN_10003540(int param_1)

{
  if (*(void **)(param_1 + 8) != (void *)(param_1 + 0x10)) {
    free(*(void **)(param_1 + 8));
  }
  return;
}



void __fastcall FUN_10003560(QObject *param_1)

{
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  puStack_8 = &this_10011779;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  *(undefined ***)param_1 = BlackMesaUIInstance::vftable;
  *(undefined ***)(param_1 + 8) = BlackMesaUIInstance::vftable;
  local_4 = 0;
  QMutex::lock((QMutex *)(*(int *)(param_1 + 0xc) + 0xc));
  FUN_10002c50(*(QObject **)(param_1 + 0xc));
  QWaitCondition::wait
            ((QWaitCondition *)(*(int *)(param_1 + 0xc) + 8),
             (QMutex *)(*(int *)(param_1 + 0xc) + 0xc),0xffffffff);
  QMutex::unlock((QMutex *)(*(int *)(param_1 + 0xc) + 0xc));
  QThread::quit(*(QThread **)(param_1 + 0x10));
  QThread::wait(*(QThread **)(param_1 + 0x10),0xffffffff);
  if (*(int **)(param_1 + 0x60) != (int *)0x0) {
    (**(code **)(**(int **)(param_1 + 0x60) + 0xc))(1);
  }
  *(undefined4 *)(param_1 + 0x60) = 0;
  operator_delete(*(void **)(param_1 + 0x34));
  *(undefined4 *)(param_1 + 0x34) = 0;
  if (*(int **)(param_1 + 0x20) != (int *)0x0) {
    (**(code **)(**(int **)(param_1 + 0x20) + 0xc))(1);
  }
  if (*(int **)(param_1 + 0x2c) != (int *)0x0) {
    (**(code **)(**(int **)(param_1 + 0x2c) + 0xc))(1);
  }
  if (*(int **)(param_1 + 0x24) != (int *)0x0) {
    (**(code **)(**(int **)(param_1 + 0x24) + 0xc))(1);
  }
  QObject::setParent(*(QObject **)(param_1 + 0x28),(QObject *)0x0);
  *(undefined4 *)(param_1 + 0x20) = 0;
  *(undefined4 *)(param_1 + 0x2c) = 0;
  *(undefined4 *)(param_1 + 0x24) = 0;
  *(undefined4 *)(param_1 + 0x28) = 0;
  if (*(int **)(param_1 + 0x1c) != (int *)0x0) {
    (**(code **)(**(int **)(param_1 + 0x1c) + 0xc))(1);
  }
  if (*(int **)(param_1 + 0x18) != (int *)0x0) {
    (**(code **)(**(int **)(param_1 + 0x18) + 0xc))(1);
  }
  *(undefined4 *)(param_1 + 0x1c) = 0;
  *(undefined4 *)(param_1 + 0x18) = 0;
  *(undefined4 *)(param_1 + 0x3c) = 0;
  local_4 = 0xffffffff;
  QObject::~QObject(param_1);
  ExceptionList = local_c;
  return;
}



void __fastcall FUN_100036b0(QObject *param_1)

{
  int *piVar1;
  int iVar2;
  uint uVar3;
  void *local_c;
  undefined1 *puStack_8;
  int local_4;
  
  puStack_8 = &LAB_100117cc;
  local_c = ExceptionList;
  uVar3 = DAT_10022088 ^ (uint)&stack0xffffffe4;
  ExceptionList = &local_c;
  local_4 = 3;
  QMutex::~QMutex((QMutex *)(param_1 + 0x68));
  piVar1 = *(int **)(param_1 + 0x4c);
  local_4._0_1_ = 2;
  if (piVar1 != (int *)0x0) {
    LOCK();
    iVar2 = piVar1[1] + -1;
    piVar1[1] = iVar2;
    UNLOCK();
    if (iVar2 == 0) {
      (*(code *)piVar1[2])(piVar1,uVar3);
    }
    LOCK();
    iVar2 = *piVar1;
    *piVar1 = *piVar1 + -1;
    UNLOCK();
    if (iVar2 == 1) {
      operator_delete(piVar1);
    }
  }
  local_4._0_1_ = 1;
  QMutex::~QMutex((QMutex *)(param_1 + 0xc));
  local_4 = (uint)local_4._1_3_ << 8;
  QWaitCondition::~QWaitCondition((QWaitCondition *)(param_1 + 8));
  local_4 = 0xffffffff;
  QObject::~QObject(param_1);
  ExceptionList = local_c;
  return;
}



// param_2 parameter of registerNormalizedType
// 
// param_1 parameter of qInstallMessageHandler
// 

void param_2_10003760(void)

{
  return;
}



int __thiscall FUN_10003770(void *this,QString *param_1)

{
  int iVar1;
  QString *pQVar2;
  bool bVar3;
  void *pvVar4;
  QVariant *pQVar5;
  int *piVar6;
  QVariant aQStack_1c [16];
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100117f9;
  local_c = ExceptionList;
  ExceptionList = &local_c;
                    // WARNING: Load size is inaccurate
  if ((**this != 1) && (**this != 0)) {
    FUN_10004230((int *)this);
  }
  pQVar2 = param_1;
                    // WARNING: Load size is inaccurate
  if (*(void **)(*this + 0xc) != (void *)0x0) {
    pvVar4 = FUN_10004580(*(void **)(*this + 0xc),param_1);
    if (pvVar4 != (void *)0x0) {
      bVar3 = operator<(pQVar2,(QString *)((int)pvVar4 + 0xc));
      if (!bVar3) {
        ExceptionList = local_c;
        return (int)pvVar4 + 0x10;
      }
    }
  }
  pQVar5 = (QVariant *)QVariant::QVariant(aQStack_1c);
  uStack_4 = 0;
  piVar6 = FUN_100044b0(this,&param_1,pQVar2,pQVar5);
  uStack_4 = 0xffffffff;
  iVar1 = *piVar6;
  QVariant::~QVariant(aQStack_1c);
  ExceptionList = local_c;
  return iVar1 + 0x10;
}



void FUN_10003840(undefined4 *param_1)

{
  *param_1 = &DAT_10014f80;
  return;
}



void FUN_10003860(undefined4 *param_1)

{
  *param_1 = &DAT_10014e00;
  return;
}



void __thiscall FUN_10003876(void *this,byte param_1)

{
  FUN_10003890((void *)((int)this + -8),param_1);
  return;
}



void __thiscall FUN_1000387e(void *this,byte param_1)

{
  FUN_10003970((void *)((int)this + -8),param_1);
  return;
}



void __thiscall FUN_10003886(void *this,byte param_1)

{
  FUN_10003a10((void *)((int)this + -8),param_1);
  return;
}



void * __thiscall FUN_10003890(void *this,byte param_1)

{
  FUN_10003560((QObject *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_100038b0(void *this,byte param_1)

{
  FUN_100036b0((QObject *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_100038d0(void *this,byte param_1)

{
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_100038f0(void *this,byte param_1)

{
  QFocusEvent::~QFocusEvent((QFocusEvent *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10003910(void *this,byte param_1)

{
  QGuiApplication::~QGuiApplication((QGuiApplication *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10003930(void *this,byte param_1)

{
  QKeyEvent::~QKeyEvent((QKeyEvent *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10003950(void *this,byte param_1)

{
  QMouseEvent::~QMouseEvent((QMouseEvent *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10003970(void *this,byte param_1)

{
  QOffscreenSurface::~QOffscreenSurface((QOffscreenSurface *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10003990(void *this,byte param_1)

{
  QOpenGLContext::~QOpenGLContext((QOpenGLContext *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_100039b0(void *this,byte param_1)

{
  QQmlComponent::~QQmlComponent((QQmlComponent *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_100039d0(void *this,byte param_1)

{
  QQmlEngine::~QQmlEngine((QQmlEngine *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_100039f0(void *this,byte param_1)

{
  QQuickRenderControl::~QQuickRenderControl((QQuickRenderControl *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10003a10(void *this,byte param_1)

{
  QQuickWindow::~QQuickWindow((QQuickWindow *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10003a30(void *this,byte param_1)

{
  QThread::~QThread((QThread *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10003a50(void *this,byte param_1)

{
  QTimer::~QTimer((QTimer *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10003a70(void *this,byte param_1)

{
  QWheelEvent::~QWheelEvent((QWheelEvent *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



// param_3 parameter of registerNormalizedType
// 

undefined4 * __cdecl param_3_10003ab0(undefined4 *param_1,undefined4 *param_2)

{
  if (param_2 == (undefined4 *)0x0) {
    return param_1;
  }
  if (param_1 != (undefined4 *)0x0) {
    *param_1 = *param_2;
    return param_1;
  }
  return (undefined4 *)0x0;
}



// WARNING: Globals starting with '_' overlap smaller symbols at the same address
// WARNING: Exceeded maximum restarts with more pending

void __thiscall FUN_10003af0(void *this,undefined4 param_1,char **param_2)

{
  char **ppcVar1;
  uint uVar2;
  QGuiApplication *this_00;
  QByteArray *pQVar3;
  _func_void *p_Var4;
  QOpenGLContext *pQVar5;
  QOffscreenSurface *pQVar6;
  QSurfaceFormat *pQVar7;
  QQuickRenderControl *this_01;
  QQuickWindow *this_02;
  QColor *pQVar8;
  QFocusEvent *this_03;
  void *pvVar9;
  QQmlEngine *this_04;
  QQmlIncubationController *pQVar10;
  QObject *pQVar11;
  QThread *this_05;
  undefined4 *puVar12;
  QTimer *this_06;
  code *pcVar13;
  QGuiApplication *pQStack_2c;
  QTypedArrayData<> *local_28;
  QByteArray aQStack_24 [16];
  uint uStack_14;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  ppcVar1 = param_2;
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100118bd;
  local_c = ExceptionList;
  local_10 = (void *)(DAT_10022088 ^ (uint)&pQStack_2c);
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffc8;
  ExceptionList = &local_c;
  if (*(int *)self_exref == 0) {
    FUN_100066b0();
    pcVar13 = param_2_10003760;
    qInstallMessageHandler(param_2_10003760);
    FUN_10003000("CrowbarCollective",1,0,"BlackMesaEngine",&LAB_10003a90,pcVar13,uVar2);
    QCoreApplication::setAttribute(0x10,true);
    this_00 = (QGuiApplication *)operator_new(8);
    uStack_4 = 0;
    pQStack_2c = this_00;
    if (this_00 == (QGuiApplication *)0x0) {
      _DAT_100225d4 = (QGuiApplication *)0x0;
    }
    else {
      QGuiApplication::QGuiApplication(this_00,&param_1,ppcVar1,0x50909);
      *(undefined ***)this_00 = QGuiApplication::vftable;
      _DAT_100225d4 = this_00;
    }
    pQVar3 = (QByteArray *)FUN_10005e50((undefined4 *)aQStack_24);
    uStack_4 = 1;
    p_Var4 = QGuiApplication::platformFunction(pQVar3);
    uStack_4 = 0xffffffff;
    QByteArray::~QByteArray(aQStack_24);
    if (p_Var4 != (_func_void *)0x0) {
      (*p_Var4)(1);
    }
    QQuickWindow::setDefaultAlphaBuffer(true);
  }
  QSurfaceFormat::QSurfaceFormat((QSurfaceFormat *)&local_28);
  uStack_4 = 2;
  QSurfaceFormat::setDepthBufferSize((QSurfaceFormat *)&local_28,0x18);
  QSurfaceFormat::setStencilBufferSize((QSurfaceFormat *)&local_28,8);
  QSurfaceFormat::setRedBufferSize((QSurfaceFormat *)&local_28,8);
  QSurfaceFormat::setGreenBufferSize((QSurfaceFormat *)&local_28,8);
  QSurfaceFormat::setBlueBufferSize((QSurfaceFormat *)&local_28,8);
  QSurfaceFormat::setAlphaBufferSize((QSurfaceFormat *)&local_28,8);
  QSurfaceFormat::setSamples((QSurfaceFormat *)&local_28,0);
  QSurfaceFormat::setSwapBehavior((QSurfaceFormat *)&local_28,2);
  QSurfaceFormat::setSwapInterval((QSurfaceFormat *)&local_28,0);
  QSurfaceFormat::setRenderableType((QSurfaceFormat *)&local_28,2);
  pQVar5 = (QOpenGLContext *)operator_new(8);
  uStack_4._0_1_ = 3;
  pQStack_2c = (QGuiApplication *)pQVar5;
  if (pQVar5 == (QOpenGLContext *)0x0) {
    pQVar5 = (QOpenGLContext *)0x0;
  }
  else {
    QOpenGLContext::QOpenGLContext(pQVar5,(QObject *)0x0);
    *(undefined ***)pQVar5 = QOpenGLContext::vftable;
  }
  uStack_4._0_1_ = 2;
  *(QOpenGLContext **)((int)this + 0x18) = pQVar5;
  QOpenGLContext::setFormat(pQVar5,(QSurfaceFormat *)&local_28);
  QOpenGLContext::setShareContext
            (*(QOpenGLContext **)((int)this + 0x18),*(QOpenGLContext **)((int)this + 0x14));
  QOpenGLContext::create(*(QOpenGLContext **)((int)this + 0x18));
  pQVar6 = (QOffscreenSurface *)operator_new(0x14);
  uStack_4._0_1_ = 4;
  pQStack_2c = (QGuiApplication *)pQVar6;
  if (pQVar6 == (QOffscreenSurface *)0x0) {
    pQVar6 = (QOffscreenSurface *)0x0;
  }
  else {
    QOffscreenSurface::QOffscreenSurface(pQVar6,(QScreen *)0x0);
    *(undefined ***)pQVar6 = QOffscreenSurface::vftable;
    *(undefined ***)(pQVar6 + 8) = QOffscreenSurface::vftable;
  }
  uStack_4 = CONCAT31(uStack_4._1_3_,2);
  *(QOffscreenSurface **)((int)this + 0x1c) = pQVar6;
  pQVar7 = (QSurfaceFormat *)QOpenGLContext::format(*(QOpenGLContext **)((int)this + 0x18));
  puStack_8._0_1_ = 5;
  QOffscreenSurface::setFormat(*(QOffscreenSurface **)((int)this + 0x1c),pQVar7);
  puStack_8._0_1_ = 2;
  QSurfaceFormat::~QSurfaceFormat((QSurfaceFormat *)&local_28);
  QOffscreenSurface::create(*(QOffscreenSurface **)((int)this + 0x1c));
  this_01 = (QQuickRenderControl *)operator_new(8);
  puStack_8._0_1_ = 6;
  if (this_01 == (QQuickRenderControl *)0x0) {
    this_01 = (QQuickRenderControl *)0x0;
  }
  else {
    QQuickRenderControl::QQuickRenderControl(this_01,(QObject *)this);
    *(undefined ***)this_01 = QQuickRenderControl::vftable;
  }
  puStack_8._0_1_ = 2;
  *(QQuickRenderControl **)((int)this + 0x20) = this_01;
  this_02 = (QQuickWindow *)operator_new(0x14);
  puStack_8._0_1_ = 7;
  if (this_02 == (QQuickWindow *)0x0) {
    this_02 = (QQuickWindow *)0x0;
  }
  else {
    QQuickWindow::QQuickWindow(this_02,*(QQuickRenderControl **)((int)this + 0x20));
    *(undefined ***)this_02 = QQuickWindow::vftable;
    *(undefined ***)(this_02 + 8) = QQuickWindow::vftable;
  }
  puStack_8._0_1_ = 2;
  *(QQuickWindow **)((int)this + 0x24) = this_02;
  QQuickWindow::setClearBeforeRendering(this_02,true);
  pQVar8 = (QColor *)QColor::QColor((QColor *)aQStack_24,0x13);
  QQuickWindow::setColor(*(QQuickWindow **)((int)this + 0x24),pQVar8);
  this_03 = (QFocusEvent *)operator_new(0x10);
  puStack_8._0_1_ = 8;
  if (this_03 == (QFocusEvent *)0x0) {
    this_03 = (QFocusEvent *)0x0;
  }
  else {
    QFocusEvent::QFocusEvent(this_03,8,3);
    *(undefined ***)this_03 = QFocusEvent::vftable;
  }
  puStack_8._0_1_ = 2;
  QCoreApplication::postEvent(*(QObject **)((int)this + 0x24),(QEvent *)this_03,0);
  QCoreApplication::processEvents(0);
  pvVar9 = operator_new(0xc);
  puStack_8._0_1_ = 9;
  if (pvVar9 == (void *)0x0) {
    pvVar9 = (void *)0x0;
  }
  else {
    pvVar9 = FUN_1000e6d0(pvVar9,0,0);
  }
  puStack_8._0_1_ = 2;
  *(void **)((int)this + 0x40) = pvVar9;
  FUN_1000ef80(pvVar9,this);
  this_04 = (QQmlEngine *)operator_new(0xc);
  puStack_8._0_1_ = 10;
  if (this_04 == (QQmlEngine *)0x0) {
    this_04 = (QQmlEngine *)0x0;
  }
  else {
    QQmlEngine::QQmlEngine(this_04,(QObject *)this);
    *(undefined ***)this_04 = QQmlEngine::vftable;
  }
  puStack_8 = (undefined1 *)CONCAT31(puStack_8._1_3_,2);
  *(QQmlEngine **)((int)this + 0x28) = this_04;
  pQVar10 = QQmlEngine::incubationController(this_04);
  if (pQVar10 == (QQmlIncubationController *)0x0) {
    pQVar10 = QQuickWindow::incubationController(*(QQuickWindow **)((int)this + 0x24));
    QQmlEngine::setIncubationController(*(QQmlEngine **)((int)this + 0x28),pQVar10);
  }
  local_28 = QString::fromAscii_helper((char *)&param_1_10014f78,4);
  puStack_8._0_1_ = 0xb;
  QQmlEngine::addImageProvider
            (*(QQmlEngine **)((int)this + 0x28),(QString *)&local_28,
             *(QQmlImageProviderBase **)((int)this + 0x40));
  puStack_8._0_1_ = 2;
  QString::~QString((QString *)&local_28);
  pQVar11 = (QObject *)operator_new(0x70);
  puStack_8._0_1_ = 0xc;
  if (pQVar11 == (QObject *)0x0) {
    pQVar11 = (QObject *)0x0;
  }
  else {
    pQVar11 = FUN_10003330(pQVar11);
  }
  *(QObject **)((int)this + 0xc) = pQVar11;
  *(undefined4 *)(pQVar11 + 0x10) = *(undefined4 *)((int)this + 0x18);
  puStack_8._0_1_ = 2;
  *(undefined4 *)(*(int *)((int)this + 0xc) + 0x14) = *(undefined4 *)((int)this + 0x1c);
  *(undefined4 *)(*(int *)((int)this + 0xc) + 0x18) = *(undefined4 *)((int)this + 0x24);
  *(undefined4 *)(*(int *)((int)this + 0xc) + 0x1c) = *(undefined4 *)((int)this + 0x20);
  this_05 = (QThread *)operator_new(8);
  puStack_8._0_1_ = 0xd;
  if (this_05 == (QThread *)0x0) {
    this_05 = (QThread *)0x0;
  }
  else {
    QThread::QThread(this_05,(QObject *)0x0);
    *(undefined ***)this_05 = QThread::vftable;
  }
  puStack_8._0_1_ = 2;
  *(QThread **)((int)this + 0x10) = this_05;
  QQuickRenderControl::prepareThread(*(QQuickRenderControl **)((int)this + 0x20),this_05);
  QObject::moveToThread(*(QObject **)((int)this + 0x18),*(QThread **)((int)this + 0x10));
  QObject::moveToThread(*(QObject **)((int)this + 0xc),*(QThread **)((int)this + 0x10));
  puVar12 = (undefined4 *)operator_new(0x10);
  if (puVar12 == (undefined4 *)0x0) {
    puVar12 = (undefined4 *)0x0;
  }
  else {
    *puVar12 = 0;
    puVar12[1] = 0x80000000;
    puVar12[2] = 0;
    puVar12[3] = 0x80000000;
  }
  *(undefined4 **)((int)this + 0x34) = puVar12;
  this_06 = (QTimer *)operator_new(0x18);
  puStack_8._0_1_ = 0xe;
  if (this_06 == (QTimer *)0x0) {
    this_06 = (QTimer *)0x0;
  }
  else {
    QTimer::QTimer(this_06,(QObject *)0x0);
    *(undefined ***)this_06 = QTimer::vftable;
  }
  pcVar13 = timeout_exref;
  *(QTimer **)((int)this + 0x60) = this_06;
  *(uint *)(this_06 + 0x14) = *(uint *)(this_06 + 0x14) & 0xfffffffe;
  puStack_8 = (undefined1 *)CONCAT31(puStack_8._1_3_,2);
  FUN_10002f30((QObject *)&local_28,*(void ***)((int)this + 0x60),pcVar13,(void **)this,FUN_10005900
               ,0,(int *)0x0);
  QMetaObject::Connection::~Connection((Connection *)&local_28);
  QThread::start(*(QThread **)((int)this + 0x10),7);
  FUN_10002ec0((QObject *)&local_28,*(void ***)((int)this + 0x20),renderRequested_exref,
               (void **)this,FUN_10005d20,0,(int *)0x0);
  QMetaObject::Connection::~Connection((Connection *)&local_28);
  FUN_10002ec0((QObject *)&stack0xffffffd0,*(void ***)((int)this + 0x20),sceneChanged_exref,
               (void **)this,FUN_10005d20,0,(int *)0x0);
  QMetaObject::Connection::~Connection((Connection *)&stack0xffffffd0);
  puStack_8 = (undefined1 *)0xffffffff;
  QSurfaceFormat::~QSurfaceFormat((QSurfaceFormat *)&pQStack_2c);
  ExceptionList = local_10;
  FUN_10010b2e(uStack_14 ^ (uint)&stack0xffffffd0);
  return;
}



QMapNodeBase * __thiscall FUN_100040b0(void *this,void *param_1)

{
  QMapNodeBase *pQVar1;
  QMapNodeBase *pQVar2;
  
  pQVar1 = FUN_10004130(param_1,(QString *)((int)this + 0xc),(QVariant *)((int)this + 0x10),
                        (QMapNodeBase *)0x0,false);
                    // WARNING: Load size is inaccurate
  if ((*this & 1) == 0) {
    *(uint *)pQVar1 = *(uint *)pQVar1 & 0xfffffffe;
  }
  else {
    *(uint *)pQVar1 = *(uint *)pQVar1 | 1;
  }
  if (*(void **)((int)this + 4) == (void *)0x0) {
    *(undefined4 *)(pQVar1 + 4) = 0;
  }
  else {
    pQVar2 = FUN_100040b0(*(void **)((int)this + 4),param_1);
    *(QMapNodeBase **)(pQVar1 + 4) = pQVar2;
    *(uint *)pQVar2 = *(uint *)pQVar2 & 3 | (uint)pQVar1;
  }
  if (*(void **)((int)this + 8) != (void *)0x0) {
    pQVar2 = FUN_100040b0(*(void **)((int)this + 8),param_1);
    *(QMapNodeBase **)(pQVar1 + 8) = pQVar2;
    *(uint *)pQVar2 = *(uint *)pQVar2 & 3 | (uint)pQVar1;
    return pQVar1;
  }
  *(undefined4 *)(pQVar1 + 8) = 0;
  return pQVar1;
}



QMapNodeBase * __thiscall
FUN_10004130(void *this,QString *param_1,QVariant *param_2,QMapNodeBase *param_3,bool param_4)

{
  QMapNodeBase *pQVar1;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_10011904;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
  pQVar1 = QMapDataBase::createNode((QMapDataBase *)this,0x20,8,param_3,param_4);
  local_8 = 0;
  if ((QString *)(pQVar1 + 0xc) != (QString *)0x0) {
    QString::QString((QString *)(pQVar1 + 0xc),param_1);
  }
  local_8 = CONCAT31(local_8._1_3_,2);
  if ((QVariant *)(pQVar1 + 0x10) != (QVariant *)0x0) {
    QVariant::QVariant((QVariant *)(pQVar1 + 0x10),param_2);
  }
  ExceptionList = local_10;
  return pQVar1;
}



void Catch_All_100041b7(void)

{
  int unaff_EBP;
  
  QString::~QString((QString *)(*(int *)(unaff_EBP + 0x14) + 0xc));
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void Catch_All_100041cc(void)

{
  int unaff_EBP;
  
  QMapDataBase::freeNodeAndRebalance
            (*(QMapDataBase **)(unaff_EBP + -0x14),*(QMapNodeBase **)(unaff_EBP + 0x14));
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void __fastcall FUN_100041f0(int param_1)

{
  do {
    QString::~QString((QString *)(param_1 + 0xc));
    QVariant::~QVariant((QVariant *)(param_1 + 0x10));
    if (*(int *)(param_1 + 4) != 0) {
      FUN_100041f0(*(int *)(param_1 + 4));
    }
    param_1 = *(int *)(param_1 + 8);
  } while (param_1 != 0);
  return;
}



void __fastcall FUN_10004230(int *param_1)

{
  int iVar1;
  int *piVar2;
  QMapDataBase *this;
  QMapDataBase *this_00;
  QMapNodeBase *pQVar3;
  
  this_00 = QMapDataBase::createData();
  if (*(void **)(*param_1 + 0xc) != (void *)0x0) {
    pQVar3 = FUN_100040b0(*(void **)(*param_1 + 0xc),this_00);
    *(QMapNodeBase **)(this_00 + 0xc) = pQVar3;
    *(uint *)pQVar3 = *(uint *)pQVar3 & 3 | (uint)(this_00 + 8);
  }
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) goto LAB_1000429c;
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) goto LAB_1000429c;
  }
  this = (QMapDataBase *)*param_1;
  if (*(int *)(this + 0xc) != 0) {
    FUN_100041f0(*(int *)(this + 0xc));
    QMapDataBase::freeTree(this,*(QMapNodeBase **)(this + 0xc),8);
  }
  QMapDataBase::freeData(this);
LAB_1000429c:
  *param_1 = (int)this_00;
                    // WARNING: Could not recover jumptable at 0x100042a2. Too many branches
                    // WARNING: Treating indirect jump as call
  QMapDataBase::recalcMostLeftNode(this_00);
  return;
}



undefined4 __fastcall FUN_100042b0(int param_1)

{
  return *(undefined4 *)(param_1 + 0x38);
}



bool __thiscall FUN_100042c0(void *this,QEvent *param_1)

{
  bool bVar1;
  __int64 _Var2;
  
  if (*(short *)(param_1 + 8) == 0x3ec) {
    _Var2 = QElapsedTimer::nsecsElapsed(*(QElapsedTimer **)((int)this + 0x34));
    if ((-1 < _Var2) &&
       (((int)((ulonglong)_Var2 >> 0x20) != 0 && -1 < _Var2 || (0xa98ac6 < (uint)_Var2)))) {
      FUN_10005a40((int)this);
      QCoreApplication::processEvents(1);
      QElapsedTimer::start(*(QElapsedTimer **)((int)this + 0x34));
    }
    return true;
  }
  if (*(short *)(param_1 + 8) == 0x13) {
    FUN_10001880(*(int *)((int)this + 0xc));
    return true;
  }
  bVar1 = QObject::event((QObject *)this,param_1);
  return bVar1;
}



void __thiscall FUN_100043b0(void *this,undefined4 param_1,void *param_2,char **param_3)

{
  void *this_00;
  QQmlNetworkAccessManagerFactory *pQVar1;
  void *pvVar2;
  QString *pQVar3;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_1001193f;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  this_00 = (void *)((int)this + -8);
  FUN_10003af0(this_00,param_2,param_3);
  *(undefined4 *)((int)this + 0x30) = param_1;
  param_3 = (char **)operator_new(8);
  local_4 = 0;
  if (param_3 == (char **)0x0) {
    pQVar1 = (QQmlNetworkAccessManagerFactory *)0x0;
  }
  else {
    pQVar1 = (QQmlNetworkAccessManagerFactory *)FUN_10007480(param_3,this_00);
  }
  local_4 = 0xffffffff;
  QQmlEngine::setNetworkAccessManagerFactory(*(QQmlEngine **)((int)this + 0x20),pQVar1);
  param_3 = (char **)operator_new(0x18);
  local_4 = 1;
  if (param_3 == (char **)0x0) {
    pvVar2 = (void *)0x0;
  }
  else {
    pvVar2 = FUN_10009300(param_3,*(undefined4 *)((int)this + 0x30),(QTimer *)0x0);
  }
  *(void **)((int)this + 0x34) = pvVar2;
  pQVar3 = (QString *)FUN_10003840(&param_3);
  local_4 = 2;
  FUN_100062f0(this_00,pQVar3);
  local_4 = 0xffffffff;
  QString::~QString((QString *)&param_3);
  QCoreApplication::processEvents(0);
  ExceptionList = local_c;
  return;
}



undefined4 * __thiscall
FUN_100044b0(void *this,undefined4 *param_1,QString *param_2,QVariant *param_3)

{
  bool bVar1;
  QMapNodeBase *pQVar2;
  QMapNodeBase *pQVar3;
  QMapNodeBase *pQVar4;
  bool local_8;
  
                    // WARNING: Load size is inaccurate
  if ((**this != 1) && (**this != 0)) {
    FUN_10004230((int *)this);
  }
                    // WARNING: Load size is inaccurate
  pQVar4 = (QMapNodeBase *)0x0;
  local_8 = true;
  pQVar3 = *(QMapNodeBase **)(*this + 0xc);
  pQVar2 = (QMapNodeBase *)(*this + 8);
  if (pQVar3 != (QMapNodeBase *)0x0) {
    do {
      pQVar2 = pQVar3;
      local_8 = operator<((QString *)(pQVar2 + 0xc),param_2);
      if (local_8) {
        pQVar3 = *(QMapNodeBase **)(pQVar2 + 8);
      }
      else {
        pQVar3 = *(QMapNodeBase **)(pQVar2 + 4);
        pQVar4 = pQVar2;
      }
      local_8 = !local_8;
    } while (pQVar3 != (QMapNodeBase *)0x0);
    if ((pQVar4 != (QMapNodeBase *)0x0) &&
       (bVar1 = operator<(param_2,(QString *)(pQVar4 + 0xc)), !bVar1)) {
      QVariant::operator=((QVariant *)(pQVar4 + 0x10),param_3);
      *param_1 = pQVar4;
      return param_1;
    }
  }
                    // WARNING: Load size is inaccurate
  pQVar3 = FUN_10004130(*this,param_2,param_3,pQVar2,local_8);
  *param_1 = pQVar3;
  return param_1;
}



void * __thiscall FUN_10004580(void *this,QString *param_1)

{
  bool bVar1;
  void *pvVar2;
  void *pvVar3;
  
  pvVar3 = (void *)0x0;
  if (this != (void *)0x0) {
    do {
      bVar1 = operator<((QString *)((int)this + 0xc),param_1);
      if (bVar1) {
        pvVar2 = *(void **)((int)this + 8);
      }
      else {
        pvVar2 = *(void **)((int)this + 4);
        pvVar3 = this;
      }
      this = pvVar2;
    } while (pvVar2 != (void *)0x0);
  }
  return pvVar3;
}



void __thiscall FUN_100045c0(void *this,int param_1,int param_2)

{
  double *pdVar1;
  uint uVar2;
  QMouseEvent *pQVar3;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011ccb;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  if (*(char *)((int)this + 0x3c) != '\0') {
    pdVar1 = (double *)((int)this + 0x40);
    *pdVar1 = (double)param_1;
    *(double *)((int)this + 0x48) = (double)param_2;
    pQVar3 = (QMouseEvent *)operator_new(0x60);
    local_4 = 0;
    if (pQVar3 == (QMouseEvent *)0x0) {
      pQVar3 = (QMouseEvent *)0x0;
    }
    else {
      QMouseEvent::QMouseEvent(pQVar3,5,pdVar1,pdVar1,0,*(undefined4 *)((int)this + 0x50),0,uVar2);
      *(undefined ***)pQVar3 = QMouseEvent::vftable;
    }
    local_4 = 0xffffffff;
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar3,0);
  }
  ExceptionList = local_c;
  return;
}



void __fastcall FUN_10004680(int param_1)

{
  *(undefined4 *)(param_1 + 0x5c) = 0x1ffffff;
  QTimer::stop(*(QTimer **)(param_1 + 0x58));
  FUN_1000f450(*(QObject **)(param_1 + 0x34));
  return;
}



void __fastcall FUN_100046a0(int param_1)

{
  *(undefined4 *)(param_1 + 0x5c) = 0x1ffffff;
  QTimer::stop(*(QTimer **)(param_1 + 0x58));
  FUN_1000f470(*(QObject **)(param_1 + 0x34));
  return;
}



void __fastcall FUN_100046c0(int param_1)

{
  FUN_1000f490(*(QObject **)(param_1 + 0x34));
  return;
}



void __thiscall FUN_100046d0(void *this,float *param_1,float param_2,int param_3)

{
  QString *pQVar1;
  QString aQStack_24 [4];
  undefined1 local_20 [16];
  uint local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011969;
  local_c = ExceptionList;
  local_10 = DAT_10022088 ^ (uint)aQStack_24;
  ExceptionList = &local_c;
  QColor::fromRgbF((double)CONCAT44(SUB84((double)*param_1,0),local_20),
                   (double)CONCAT44(SUB84((double)param_1[1],0),
                                    (int)((ulonglong)(double)*param_1 >> 0x20)),
                   (double)CONCAT44(SUB84((double)param_1[2],0),
                                    (int)((ulonglong)(double)param_1[1] >> 0x20)),
                   (double)CONCAT44(SUB84((double)param_2,0),
                                    (int)((ulonglong)(double)param_1[2] >> 0x20)));
  pQVar1 = (QString *)QString::fromUtf8((char *)aQStack_24,param_3);
  uStack_4 = 0;
  FUN_1000d510(*(void **)((int)this + 0x34),local_20,pQVar1);
  uStack_4 = 0xffffffff;
  QString::~QString(aQStack_24);
  ExceptionList = local_c;
  FUN_10010b2e(local_10 ^ (uint)aQStack_24);
  return;
}



void __thiscall FUN_100047b0(void *this,int param_1)

{
  QString *pQVar1;
  undefined4 uVar2;
  QString local_24 [4];
  QColor aQStack_20 [16];
  uint local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100119a9;
  local_c = ExceptionList;
  local_10 = DAT_10022088 ^ (uint)local_24;
  ExceptionList = &local_c;
  pQVar1 = (QString *)QString::fromUtf8((char *)local_24,param_1);
  uStack_4 = 0;
  uVar2 = QColor::QColor(aQStack_20,6);
  FUN_1000d510(*(void **)((int)this + 0x34),uVar2,pQVar1);
  uStack_4 = 0xffffffff;
  QString::~QString(local_24);
  ExceptionList = local_c;
  FUN_10010b2e(local_10 ^ (uint)local_24);
  return;
}



void __fastcall FUN_10004850(int param_1)

{
  *(undefined4 *)(param_1 + 0x5c) = 0x1ffffff;
  QTimer::stop(*(QTimer **)(param_1 + 0x58));
  FUN_1000f4b0(*(QObject **)(param_1 + 0x34));
  return;
}



void __fastcall FUN_10004870(int param_1)

{
  *(undefined4 *)(param_1 + 0x5c) = 0x1ffffff;
  QTimer::stop(*(QTimer **)(param_1 + 0x58));
  FUN_1000f500(*(QObject **)(param_1 + 0x34));
  return;
}



void __fastcall FUN_10004890(int param_1)

{
  *(undefined4 *)(param_1 + 0x5c) = 0x1ffffff;
  QTimer::stop(*(QTimer **)(param_1 + 0x58));
  FUN_1000f520(*(QObject **)(param_1 + 0x34));
  return;
}



void __fastcall FUN_100048b0(int param_1)

{
  FUN_1000f540(*(QObject **)(param_1 + 0x34));
  return;
}



void __thiscall FUN_100048c0(void *this,int param_1)

{
  undefined4 uVar1;
  uint uVar2;
  QKeyEvent *pQVar3;
  undefined4 uVar4;
  bool bVar5;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011a05;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  if (*(char *)((int)this + 0x3c) != '\0') {
    uVar1 = FUN_10007430(param_1);
    uVar2 = FUN_100073e0(uVar1);
    *(uint *)((int)this + 0x54) = *(uint *)((int)this + 0x54) | uVar2;
    if (uVar2 == 0) {
      *(undefined4 *)((int)this + 0x5c) = uVar1;
      QTimer::setInterval(*(QTimer **)((int)this + 0x58),0xf0);
      QTimer::start(*(QTimer **)((int)this + 0x58));
    }
    FUN_1000f6d0(*(QObject **)((int)this + 0x34));
    pQVar3 = (QKeyEvent *)operator_new(0x2c);
    uStack_4 = 0;
    bVar5 = pQVar3 == (QKeyEvent *)0x0;
    if (bVar5) {
      pQVar3 = (QKeyEvent *)0x0;
    }
    else {
      uVar4 = QString::QString((QString *)&param_1);
      uStack_4 = CONCAT31(uStack_4._1_3_,1);
      QKeyEvent::QKeyEvent(pQVar3,6,uVar1,*(undefined4 *)((int)this + 0x54),uVar4,0,1);
      *(undefined ***)pQVar3 = QKeyEvent::vftable;
    }
    uStack_4 = 0xffffffff;
    if (!bVar5) {
      QString::~QString((QString *)&param_1);
    }
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar3,0);
  }
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_100049d0(void *this,int param_1)

{
  int iVar1;
  uint uVar2;
  QKeyEvent *pQVar3;
  undefined4 uVar4;
  bool bVar5;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011a05;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  if (*(char *)((int)this + 0x3c) != '\0') {
    iVar1 = FUN_10007430(param_1);
    uVar2 = FUN_100073e0(iVar1);
    *(uint *)((int)this + 0x54) = *(uint *)((int)this + 0x54) & ~uVar2;
    if ((uVar2 == 0) && (*(int *)((int)this + 0x5c) == iVar1)) {
      *(undefined4 *)((int)this + 0x5c) = 0x1ffffff;
      QTimer::stop(*(QTimer **)((int)this + 0x58));
    }
    pQVar3 = (QKeyEvent *)operator_new(0x2c);
    uStack_4 = 0;
    bVar5 = pQVar3 == (QKeyEvent *)0x0;
    if (bVar5) {
      pQVar3 = (QKeyEvent *)0x0;
    }
    else {
      uVar4 = QString::QString((QString *)&param_1);
      uStack_4 = CONCAT31(uStack_4._1_3_,1);
      QKeyEvent::QKeyEvent(pQVar3,7,iVar1,*(undefined4 *)((int)this + 0x54),uVar4,0,1);
      *(undefined ***)pQVar3 = QKeyEvent::vftable;
    }
    uStack_4 = 0xffffffff;
    if (!bVar5) {
      QString::~QString((QString *)&param_1);
    }
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar3,0);
  }
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_10004ad0(void *this,undefined2 param_1)

{
  uint uVar1;
  QKeyEvent *pQVar2;
  undefined4 uVar3;
  QKeyEvent *pQVar4;
  QKeyEvent *local_14;
  QKeyEvent *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011a6a;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffdc;
  ExceptionList = &local_c;
  if (*(char *)((int)this + 0x3c) != '\0') {
    pQVar2 = (QKeyEvent *)operator_new(0x2c);
    local_4 = 0;
    local_10 = pQVar2;
    if (pQVar2 == (QKeyEvent *)0x0) {
      pQVar4 = (QKeyEvent *)0x0;
    }
    else {
      uVar3 = QString::QString((QString *)&local_14,param_1,uVar1);
      puStack_8 = (undefined1 *)CONCAT31(puStack_8._1_3_,1);
      QKeyEvent::QKeyEvent(pQVar2,6,0x1ffffff,*(undefined4 *)((int)this + 0x54),uVar3,0,1);
      *(undefined ***)pQVar2 = QKeyEvent::vftable;
      pQVar4 = pQVar2;
    }
    local_4 = 0xffffffff;
    if (pQVar2 != (QKeyEvent *)0x0) {
      QString::~QString((QString *)&local_14);
    }
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar4,0);
    pQVar2 = (QKeyEvent *)operator_new(0x2c);
    local_4 = 3;
    local_14 = pQVar2;
    if (pQVar2 == (QKeyEvent *)0x0) {
      pQVar4 = (QKeyEvent *)0x0;
    }
    else {
      uVar3 = QString::QString((QString *)&local_10,param_1);
      puStack_8 = (undefined1 *)CONCAT31(puStack_8._1_3_,4);
      QKeyEvent::QKeyEvent(pQVar2,7,0x1ffffff,*(undefined4 *)((int)this + 0x54),uVar3,0,1);
      *(undefined ***)pQVar2 = QKeyEvent::vftable;
      pQVar4 = pQVar2;
    }
    local_4 = 0xffffffff;
    if (pQVar2 != (QKeyEvent *)0x0) {
      QString::~QString((QString *)&local_10);
    }
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar4,0);
  }
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_10004c30(void *this,undefined4 param_1,char *param_2,QTypedArrayData<> *param_3)

{
  QTypedArrayData<> QVar1;
  char cVar2;
  char *pcVar3;
  QTypedArrayData<> *pQVar4;
  int iVar5;
  QTypedArrayData<> *pQStack_10;
  void *local_c;
  undefined1 *puStack_8;
  int iStack_4;
  
  iStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011aa2;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  *(undefined4 *)((int)this + 0x5c) = 0x1ffffff;
  pQStack_10 = (QTypedArrayData<> *)this;
  QTimer::stop(*(QTimer **)((int)this + 0x58));
  if (param_3 == (QTypedArrayData<> *)0x0) {
    iVar5 = -1;
  }
  else {
    pQVar4 = param_3;
    do {
      QVar1 = *pQVar4;
      pQVar4 = pQVar4 + 1;
    } while (QVar1 != (QTypedArrayData<>)0x0);
    iVar5 = (int)pQVar4 - (int)(param_3 + 1);
  }
  pQStack_10 = QString::fromAscii_helper((char *)param_3,iVar5);
  iStack_4 = 0;
  if (param_2 == (char *)0x0) {
    iVar5 = -1;
  }
  else {
    pcVar3 = param_2;
    do {
      cVar2 = *pcVar3;
      pcVar3 = pcVar3 + 1;
    } while (cVar2 != '\0');
    iVar5 = (int)pcVar3 - (int)(param_2 + 1);
  }
  param_3 = QString::fromAscii_helper(param_2,iVar5);
  iStack_4._0_1_ = 1;
  FUN_1000f570(*(void **)((int)this + 0x34),param_1,&param_3,&pQStack_10);
  iStack_4 = (uint)iStack_4._1_3_ << 8;
  QString::~QString((QString *)&param_3);
  iStack_4 = 0xffffffff;
  QString::~QString((QString *)&pQStack_10);
  ExceptionList = local_c;
  return;
}



void __thiscall
FUN_10004d20(void *this,QTypedArrayData<> *param_1,undefined4 param_2,undefined4 param_3)

{
  QTypedArrayData<> QVar1;
  QTypedArrayData<> *pQVar2;
  int iVar3;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011ac9;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  *(undefined4 *)((int)this + 0x5c) = 0x1ffffff;
  QTimer::stop(*(QTimer **)((int)this + 0x58));
  if (param_1 == (QTypedArrayData<> *)0x0) {
    iVar3 = -1;
  }
  else {
    pQVar2 = param_1;
    do {
      QVar1 = *pQVar2;
      pQVar2 = pQVar2 + 1;
    } while (QVar1 != (QTypedArrayData<>)0x0);
    iVar3 = (int)pQVar2 - (int)(param_1 + 1);
  }
  param_1 = QString::fromAscii_helper((char *)param_1,iVar3);
  uStack_4 = 0;
  FUN_1000f5d0(*(void **)((int)this + 0x34),&param_1);
  uStack_4 = 0xffffffff;
  QString::~QString((QString *)&param_1);
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_10004dd0(void *this,int param_1)

{
  QString *this_00;
  undefined4 uVar1;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011b02;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_10 = this;
  this_00 = (QString *)QString::number((uint)&local_10,param_1);
  uStack_4 = 0;
  uVar1 = QString::toUpper(this_00);
  puStack_8._0_1_ = 1;
  FUN_1000f630(*(void **)((int)this + 0x34),uVar1);
  puStack_8 = (undefined1 *)((uint)puStack_8._1_3_ << 8);
  QString::~QString((QString *)&stack0x00000000);
  puStack_8 = (undefined1 *)0xffffffff;
  QString::~QString((QString *)&stack0xffffffec);
  ExceptionList = local_10;
  return;
}



void FUN_10004e60(QTypedArrayData<> *param_1,int param_2)

{
  int iVar1;
  QTypedArrayData<> *pQVar2;
  QString *pQVar3;
  QVariant *pQVar4;
  QDateTime *pQVar5;
  undefined4 uVar6;
  QMapDataBase *unaff_EBX;
  QVariant *pQVar7;
  code *local_28;
  int local_24 [2];
  QVariant aQStack_1c [12];
  void *pvStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  pQVar2 = param_1;
  puStack_8 = &param_1_10011c5a;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_28 = shared_null_exref;
  local_4 = 0;
  pQVar3 = (QString *)QString::fromUtf8((char *)local_24,(int)param_1);
  local_4._0_1_ = 1;
  QVariant::QVariant(aQStack_1c,pQVar3);
  local_4._0_1_ = 2;
  param_1 = QString::fromAscii_helper((char *)&param_1_10014fb8,4);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 3;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 2;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 1;
  QVariant::~QVariant(aQStack_1c);
  local_4._0_1_ = 0;
  QString::~QString((QString *)local_24);
  pQVar3 = (QString *)QString::fromUtf8((char *)local_24,(int)(pQVar2 + 0x80));
  local_4._0_1_ = 4;
  QVariant::QVariant(aQStack_1c,pQVar3);
  local_4._0_1_ = 5;
  param_1 = QString::fromAscii_helper((char *)&param_1_10014fc0,3);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 6;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 5;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 4;
  QVariant::~QVariant(aQStack_1c);
  local_4._0_1_ = 0;
  QString::~QString((QString *)local_24);
  pQVar3 = (QString *)QString::fromUtf8((char *)local_24,(int)(pQVar2 + 0x100));
  local_4._0_1_ = 7;
  QVariant::QVariant(aQStack_1c,pQVar3);
  local_4._0_1_ = 8;
  param_1 = QString::fromAscii_helper("gameDirectory",0xd);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 9;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 8;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 7;
  QVariant::~QVariant(aQStack_1c);
  local_4._0_1_ = 0;
  QString::~QString((QString *)local_24);
  pQVar3 = (QString *)QString::fromUtf8((char *)local_24,(int)(pQVar2 + 0x180));
  local_4._0_1_ = 10;
  QVariant::QVariant(aQStack_1c,pQVar3);
  local_4._0_1_ = 0xb;
  param_1 = QString::fromAscii_helper("gameDescription",0xf);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 0xc;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0xb;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 10;
  QVariant::~QVariant(aQStack_1c);
  local_4._0_1_ = 0;
  QString::~QString((QString *)local_24);
  pQVar3 = (QString *)QString::fromUtf8((char *)local_24,(int)(pQVar2 + 0x200));
  local_4._0_1_ = 0xd;
  QVariant::QVariant(aQStack_1c,pQVar3);
  local_4._0_1_ = 0xe;
  param_1 = QString::fromAscii_helper("connectionAddressString",0x17);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 0xf;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0xe;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 0xd;
  QVariant::~QVariant(aQStack_1c);
  local_4._0_1_ = 0;
  QString::~QString((QString *)local_24);
  QVariant::QVariant(aQStack_1c,*(uint *)(pQVar2 + 0x280));
  local_4._0_1_ = 0x10;
  param_1 = QString::fromAscii_helper("steamApplicationId",0x12);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 0x11;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0x10;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 0;
  QVariant::~QVariant(aQStack_1c);
  QVariant::QVariant(aQStack_1c,*(int *)(pQVar2 + 0x284));
  local_4._0_1_ = 0x12;
  param_1 = QString::fromAscii_helper((char *)&param_1_10015010,4);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 0x13;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0x12;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 0;
  QVariant::~QVariant(aQStack_1c);
  QVariant::QVariant(aQStack_1c,*(int *)(pQVar2 + 0x288));
  local_4._0_1_ = 0x14;
  param_1 = QString::fromAscii_helper("playersOnServerCurrently",0x18);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 0x15;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0x14;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 0;
  QVariant::~QVariant(aQStack_1c);
  QVariant::QVariant(aQStack_1c,*(int *)(pQVar2 + 0x28c));
  local_4._0_1_ = 0x16;
  param_1 = QString::fromAscii_helper("playersOnServerMaximum",0x16);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 0x17;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0x16;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 0;
  QVariant::~QVariant(aQStack_1c);
  QVariant::QVariant(aQStack_1c,*(int *)(pQVar2 + 0x290));
  local_4._0_1_ = 0x18;
  param_1 = QString::fromAscii_helper("botsOnServerCurrently",0x15);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 0x19;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0x18;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 0;
  QVariant::~QVariant(aQStack_1c);
  QVariant::QVariant(aQStack_1c,(bool)pQVar2[0x294]);
  local_4._0_1_ = 0x1a;
  param_1 = QString::fromAscii_helper("isPasswordProtected",0x13);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 0x1b;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0x1a;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 0;
  QVariant::~QVariant(aQStack_1c);
  QVariant::QVariant(aQStack_1c,(bool)pQVar2[0x295]);
  local_4._0_1_ = 0x1c;
  param_1 = QString::fromAscii_helper("isSecure",8);
  pQVar7 = aQStack_1c;
  local_4._0_1_ = 0x1d;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0x1c;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 0;
  QVariant::~QVariant(aQStack_1c);
  pQVar5 = (QDateTime *)
           QDateTime::fromSecsSinceEpoch(CONCAT44(*(undefined4 *)(pQVar2 + 0x298),local_24),0,0);
  local_4._0_1_ = 0x1e;
  QVariant::QVariant(aQStack_1c,pQVar5);
  local_4._0_1_ = 0x1f;
  param_1 = QString::fromAscii_helper("lastPlayed",10);
  local_4._0_1_ = 0x20;
  pQVar7 = aQStack_1c;
  pQVar4 = (QVariant *)FUN_10003770(&local_28,(QString *)&param_1);
  QVariant::operator=(pQVar4,pQVar7);
  local_4._0_1_ = 0x1f;
  QString::~QString((QString *)&param_1);
  local_4._0_1_ = 0x1e;
  QVariant::~QVariant(aQStack_1c);
  local_4._0_1_ = 0;
  QDateTime::~QDateTime((QDateTime *)local_24);
  pQVar3 = (QString *)QString::number((uint)&param_2,param_2);
  local_4 = CONCAT31(local_4._1_3_,0x21);
  uVar6 = QString::toUpper(pQVar3);
  puStack_8._0_1_ = 0x22;
  FUN_1000f660(*(void **)(local_24[0] + 0x34),&stack0xffffffd4,uVar6);
  puStack_8._0_1_ = 0x21;
  QString::~QString((QString *)&stack0x00000000);
  puStack_8 = (undefined1 *)((uint)puStack_8._1_3_ << 8);
  QString::~QString((QString *)&param_1);
  puStack_8 = (undefined1 *)0xffffffff;
  if (*(int *)unaff_EBX != 0) {
    if (*(int *)unaff_EBX == -1) {
      ExceptionList = pvStack_10;
      return;
    }
    LOCK();
    iVar1 = *(int *)unaff_EBX;
    *(int *)unaff_EBX = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      ExceptionList = pvStack_10;
      return;
    }
  }
  if (*(int *)(unaff_EBX + 0xc) != 0) {
    FUN_100041f0(*(int *)(unaff_EBX + 0xc));
    QMapDataBase::freeTree(unaff_EBX,*(QMapNodeBase **)(unaff_EBX + 0xc),8);
  }
  QMapDataBase::freeData(unaff_EBX);
  ExceptionList = pvStack_10;
  return;
}



void __thiscall FUN_10005510(void *this,int param_1)

{
  uint uVar1;
  uint uVar2;
  QMouseEvent *pQVar3;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011ca1;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffe4;
  ExceptionList = &local_c;
  if (*(char *)((int)this + 0x3c) != '\0') {
    uVar2 = FUN_10007430(param_1);
    *(uint *)((int)this + 0x50) = *(uint *)((int)this + 0x50) | uVar2;
    pQVar3 = (QMouseEvent *)operator_new(0x60);
    local_4 = 0;
    if (pQVar3 == (QMouseEvent *)0x0) {
      pQVar3 = (QMouseEvent *)0x0;
    }
    else {
      QMouseEvent::QMouseEvent
                (pQVar3,2,(int)this + 0x40,(int)this + 0x40,uVar2,*(undefined4 *)((int)this + 0x50),
                 *(undefined4 *)((int)this + 0x54),uVar1);
      *(undefined ***)pQVar3 = QMouseEvent::vftable;
    }
    local_4 = 0xffffffff;
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar3,0);
    pQVar3 = (QMouseEvent *)operator_new(0x60);
    local_4 = 1;
    if (pQVar3 == (QMouseEvent *)0x0) {
      pQVar3 = (QMouseEvent *)0x0;
    }
    else {
      QMouseEvent::QMouseEvent
                (pQVar3,4,(int)this + 0x40,(int)this + 0x40,uVar2,*(undefined4 *)((int)this + 0x50),
                 *(undefined4 *)((int)this + 0x54));
      *(undefined ***)pQVar3 = QMouseEvent::vftable;
    }
    local_4 = 0xffffffff;
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar3,0);
    *(uint *)((int)this + 0x50) = *(uint *)((int)this + 0x50) & ~uVar2;
    pQVar3 = (QMouseEvent *)operator_new(0x60);
    local_4 = 2;
    if (pQVar3 == (QMouseEvent *)0x0) {
      pQVar3 = (QMouseEvent *)0x0;
    }
    else {
      QMouseEvent::QMouseEvent
                (pQVar3,3,(int)this + 0x40,(int)this + 0x40,uVar2,*(undefined4 *)((int)this + 0x50),
                 *(undefined4 *)((int)this + 0x54));
      *(undefined ***)pQVar3 = QMouseEvent::vftable;
    }
    local_4 = 0xffffffff;
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar3,0);
  }
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_10005660(void *this,int param_1)

{
  uint uVar1;
  uint uVar2;
  QMouseEvent *pQVar3;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011ccb;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  if (*(char *)((int)this + 0x3c) != '\0') {
    uVar2 = FUN_10007430(param_1);
    *(uint *)((int)this + 0x50) = *(uint *)((int)this + 0x50) | uVar2;
    pQVar3 = (QMouseEvent *)operator_new(0x60);
    local_4 = 0;
    if (pQVar3 == (QMouseEvent *)0x0) {
      pQVar3 = (QMouseEvent *)0x0;
    }
    else {
      QMouseEvent::QMouseEvent
                (pQVar3,2,(int)this + 0x40,(int)this + 0x40,uVar2,*(undefined4 *)((int)this + 0x50),
                 *(undefined4 *)((int)this + 0x54),uVar1);
      *(undefined ***)pQVar3 = QMouseEvent::vftable;
    }
    local_4 = 0xffffffff;
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar3,0);
  }
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_10005710(void *this,int param_1)

{
  uint uVar1;
  uint uVar2;
  QMouseEvent *pQVar3;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011ccb;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  if (*(char *)((int)this + 0x3c) != '\0') {
    uVar2 = FUN_10007430(param_1);
    *(uint *)((int)this + 0x50) = *(uint *)((int)this + 0x50) & ~uVar2;
    pQVar3 = (QMouseEvent *)operator_new(0x60);
    local_4 = 0;
    if (pQVar3 == (QMouseEvent *)0x0) {
      pQVar3 = (QMouseEvent *)0x0;
    }
    else {
      QMouseEvent::QMouseEvent
                (pQVar3,3,(int)this + 0x40,(int)this + 0x40,uVar2,*(undefined4 *)((int)this + 0x50),
                 *(undefined4 *)((int)this + 0x54),uVar1);
      *(undefined ***)pQVar3 = QMouseEvent::vftable;
    }
    local_4 = 0xffffffff;
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar3,0);
  }
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_100057c0(void *this,undefined4 param_1)

{
  uint uVar1;
  QWheelEvent *pQVar2;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011eeb;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  if (*(char *)((int)this + 0x3c) != '\0') {
    pQVar2 = (QWheelEvent *)operator_new(0x60);
    local_4 = 0;
    if (pQVar2 == (QWheelEvent *)0x0) {
      pQVar2 = (QWheelEvent *)0x0;
    }
    else {
      QWheelEvent::QWheelEvent
                (pQVar2,(int)this + 0x40,param_1,*(undefined4 *)((int)this + 0x50),
                 *(undefined4 *)((int)this + 0x54),2,uVar1);
      *(undefined ***)pQVar2 = QWheelEvent::vftable;
    }
    local_4 = 0xffffffff;
    QCoreApplication::postEvent(*(QObject **)((int)this + 0x1c),(QEvent *)pQVar2,0);
  }
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_10005860(void *this,undefined4 param_1,QTypedArrayData<> *param_2)

{
  QTypedArrayData<> QVar1;
  QTypedArrayData<> *pQVar2;
  int iVar3;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011cf9;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  if (param_2 == (QTypedArrayData<> *)0x0) {
    iVar3 = -1;
  }
  else {
    pQVar2 = param_2;
    do {
      QVar1 = *pQVar2;
      pQVar2 = pQVar2 + 1;
    } while (QVar1 != (QTypedArrayData<>)0x0);
    iVar3 = (int)pQVar2 - (int)(param_2 + 1);
  }
  param_2 = QString::fromAscii_helper((char *)param_2,iVar3);
  uStack_4 = 0;
  FUN_10010780(*(void **)((int)this + 0x34),param_1,&param_2);
  uStack_4 = 0xffffffff;
  QString::~QString((QString *)&param_2);
  ExceptionList = local_c;
  return;
}



void __fastcall FUN_10005900(int param_1)

{
  uint uVar1;
  QKeyEvent *pQVar2;
  undefined4 uVar3;
  QKeyEvent *pQVar4;
  QKeyEvent *local_14;
  QKeyEvent *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011a6a;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffdc;
  ExceptionList = &local_c;
  pQVar2 = (QKeyEvent *)operator_new(0x2c);
  local_4 = 0;
  local_10 = pQVar2;
  if (pQVar2 == (QKeyEvent *)0x0) {
    pQVar4 = (QKeyEvent *)0x0;
  }
  else {
    uVar3 = QString::QString((QString *)&local_14);
    local_4 = CONCAT31(local_4._1_3_,1);
    QKeyEvent::QKeyEvent
              (pQVar2,7,*(undefined4 *)(param_1 + 100),*(undefined4 *)(param_1 + 0x5c),uVar3,0,1,
               uVar1);
    *(undefined ***)pQVar2 = QKeyEvent::vftable;
    pQVar4 = pQVar2;
  }
  local_4 = 0xffffffff;
  if (pQVar2 != (QKeyEvent *)0x0) {
    QString::~QString((QString *)&local_14);
  }
  QCoreApplication::postEvent(*(QObject **)(param_1 + 0x24),(QEvent *)pQVar4,0);
  QTimer::setInterval(*(QTimer **)(param_1 + 0x60),0x28);
  pQVar2 = (QKeyEvent *)operator_new(0x2c);
  local_4 = 3;
  local_14 = pQVar2;
  if (pQVar2 == (QKeyEvent *)0x0) {
    pQVar4 = (QKeyEvent *)0x0;
  }
  else {
    uVar3 = QString::QString((QString *)&local_10);
    local_4 = CONCAT31(local_4._1_3_,4);
    QKeyEvent::QKeyEvent
              (pQVar2,6,*(undefined4 *)(param_1 + 100),*(undefined4 *)(param_1 + 0x5c),uVar3,0,1);
    *(undefined ***)pQVar2 = QKeyEvent::vftable;
    pQVar4 = pQVar2;
  }
  local_4 = 0xffffffff;
  if (pQVar2 != (QKeyEvent *)0x0) {
    QString::~QString((QString *)&local_10);
  }
  QCoreApplication::postEvent(*(QObject **)(param_1 + 0x24),(QEvent *)pQVar4,0);
  ExceptionList = local_c;
  return;
}



void __fastcall FUN_10005a40(int param_1)

{
  QMutex *pQStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011d89;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  pQStack_10 = (QMutex *)param_1;
  QQuickRenderControl::polishItems(*(QQuickRenderControl **)(param_1 + 0x20));
  pQStack_10 = (QMutex *)(*(int *)(param_1 + 0xc) + 0xc);
  if (pQStack_10 != (QMutex *)0x0) {
    QMutex::lock(pQStack_10);
    pQStack_10 = (QMutex *)((uint)pQStack_10 | 1);
  }
  uStack_4 = 0;
  FUN_10002d60(*(QObject **)(param_1 + 0xc));
  QWaitCondition::wait
            ((QWaitCondition *)(*(int *)(param_1 + 0xc) + 8),
             (QMutex *)(*(int *)(param_1 + 0xc) + 0xc),0xffffffff);
  *(undefined1 *)(param_1 + 0x45) = 0;
  QMutexLocker::unlock((QMutexLocker *)&pQStack_10);
  ExceptionList = local_c;
  return;
}



int FUN_10005ad0(void)

{
  char *pcVar1;
  QByteArray *this;
  int iVar2;
  char *pcVar3;
  char cVar4;
  QByteArray aQStack_10 [4];
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011d29;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  iVar2 = DAT_100225e8;
  if (DAT_100225e8 == 0) {
    pcVar1 = QMetaObject::className((QMetaObject *)&param_6_10022070);
    QByteArray::QByteArray(aQStack_10);
    uStack_4 = 0;
    pcVar3 = pcVar1;
    do {
      cVar4 = *pcVar3;
      pcVar3 = pcVar3 + 1;
    } while (cVar4 != '\0');
    QByteArray::reserve(aQStack_10,(int)(pcVar3 + (1 - (int)(pcVar1 + 1))));
    cVar4 = '*';
    this = QByteArray::append(aQStack_10,pcVar1);
    QByteArray::append(this,cVar4);
    iVar2 = FUN_10002fa0(aQStack_10,-1,1);
    uStack_4 = 0xffffffff;
    DAT_100225e8 = iVar2;
    QByteArray::~QByteArray(aQStack_10);
  }
  ExceptionList = local_c;
  return iVar2;
}



int FUN_10005b90(void)

{
  char cVar1;
  char *pcVar2;
  QByteArray *pQVar3;
  int iVar4;
  char *pcVar5;
  char **ppcVar6;
  QByteArray aQStack_14 [4];
  undefined4 uStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011d59;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  iVar4 = DAT_100225e4;
  if (DAT_100225e4 == 0) {
    pcVar2 = QMetaObject::className((QMetaObject *)staticMetaObject_exref);
    QByteArray::QByteArray(aQStack_14);
    uStack_4 = 0;
    pcVar5 = pcVar2;
    do {
      cVar1 = *pcVar5;
      pcVar5 = pcVar5 + 1;
    } while (cVar1 != '\0');
    QByteArray::reserve(aQStack_14,(int)(pcVar5 + (8 - (int)(pcVar2 + 1))));
    pcVar5 = "Status";
    ppcVar6 = &param_1_100150a4;
    pQVar3 = QByteArray::append(aQStack_14,pcVar2);
    pQVar3 = QByteArray::append(pQVar3,(char *)ppcVar6);
    QByteArray::append(pQVar3,pcVar5);
    uStack_10 = 0x14;
    iVar4 = QMetaType::registerNormalizedType
                      (aQStack_14,param_2_10003760,param_3_10003ab0,4,0x114,staticMetaObject_exref);
    uStack_4 = 0xffffffff;
    DAT_100225e4 = iVar4;
    QByteArray::~QByteArray(aQStack_14);
  }
  ExceptionList = local_c;
  return iVar4;
}



undefined4 __fastcall FUN_10005c80(int param_1)

{
  uint uVar1;
  QEvent *this;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011eeb;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  this = (QEvent *)operator_new(0xc);
  local_4 = 0;
  if (this == (QEvent *)0x0) {
    this = (QEvent *)0x0;
  }
  else {
    QEvent::QEvent(this,0x3ec);
    *(undefined ***)this = QEvent::vftable;
  }
  local_4 = 0xffffffff;
  QCoreApplication::postEvent((QObject *)(param_1 + -8),this,0);
  QCoreApplication::processEvents(0,uVar1);
  ExceptionList = local_c;
  return 0;
}



void __fastcall FUN_10005d20(QObject *param_1)

{
  QEvent *this;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011eeb;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  if ((param_1[0x44] != (QObject)0x0) && (param_1[0x45] == (QObject)0x0)) {
    param_1[0x45] = (QObject)0x1;
    this = (QEvent *)operator_new(0xc);
    local_4 = 0;
    if (this == (QEvent *)0x0) {
      this = (QEvent *)0x0;
    }
    else {
      QEvent::QEvent(this,0x3ec);
      *(undefined ***)this = QEvent::vftable;
    }
    local_4 = 0xffffffff;
    QCoreApplication::postEvent(param_1,this,0);
  }
  ExceptionList = local_c;
  return;
}



undefined1 __fastcall FUN_10005db0(int param_1)

{
  return *(undefined1 *)(param_1 + 0x3c);
}



void __thiscall FUN_10005dc0(void *this,undefined4 param_1,undefined4 param_2,undefined4 param_3)

{
  QMutex *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011d89;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_10 = (QMutex *)(*(int *)((int)this + 4) + 0xc);
  if (local_10 != (QMutex *)0x0) {
    QMutex::lock(local_10);
    local_10 = (QMutex *)((uint)local_10 | 1);
  }
  local_4 = 0;
  *(undefined4 *)(*(int *)((int)this + 4) + 0x20) = param_1;
  *(undefined4 *)(*(int *)((int)this + 4) + 0x24) = param_2;
  *(undefined4 *)(*(int *)((int)this + 4) + 0x28) = param_3;
  if (*(char *)((int)this + 0x3c) != '\0') {
    FUN_100063f0((int)this + -8);
  }
  QMutexLocker::unlock((QMutexLocker *)&local_10);
  ExceptionList = local_c;
  return;
}



undefined4 __cdecl FUN_10005e50(undefined4 *param_1)

{
  undefined4 extraout_EDX;
  
  FUN_10003860(param_1);
  return extraout_EDX;
}



void __fastcall FUN_10005e70(int param_1)

{
  uint uVar1;
  QEvent *this;
  QObject *pQVar2;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011eeb;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  this = (QEvent *)operator_new(0xc);
  local_4 = 0;
  if (this == (QEvent *)0x0) {
    this = (QEvent *)0x0;
  }
  else {
    QEvent::QEvent(this,0x13);
    *(undefined ***)this = QEvent::vftable;
  }
  pQVar2 = (QObject *)(param_1 + -8);
  local_4 = 0xffffffff;
  QCoreApplication::postEvent(pQVar2,this,0);
  QCoreApplication::processEvents(0,uVar1);
  if (pQVar2 != (QObject *)0x0) {
    (**(code **)(*(int *)pQVar2 + 0xc))(1);
  }
  ExceptionList = local_c;
  return;
}



void __fastcall FUN_10005f20(QObject *param_1)

{
  int iVar1;
  bool bVar2;
  QMessageLogger *pQVar3;
  QDebug *pQVar4;
  int iVar5;
  QObject *pQVar6;
  QObject *pQVar7;
  QQuickItem *pQVar8;
  Data *pDVar9;
  Data *unaff_EBP;
  int unaff_ESI;
  QQmlError *pQVar10;
  Data *this;
  Data *unaff_EDI;
  undefined1 **ppuVar11;
  undefined1 *puStack_80;
  QDebug local_4c [8];
  QMessageLogger aQStack_44 [4];
  code *pcStack_40;
  undefined4 uStack_3c;
  QMessageLogger local_34 [12];
  QMessageLogger aQStack_28 [12];
  void *pvStack_1c;
  void *pvStack_18;
  void *pvStack_14;
  undefined4 uStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011df6;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  pQVar3 = (QMessageLogger *)QMessageLogger::QMessageLogger(local_34,(char *)0x0,0,(char *)0x0);
  pQVar4 = (QDebug *)QMessageLogger::info(pQVar3);
  puStack_8 = (undefined1 *)0x0;
  QDebug::operator<<(pQVar4,"Loading Black Mesa UI instance...");
  puStack_8 = (undefined1 *)0xffffffff;
  QDebug::~QDebug((QDebug *)&stack0xffffffb0);
  pcStack_40 = FUN_10005f20;
  uStack_3c = 0;
  QObject::disconnectImpl
            (*(QObject **)(param_1 + 0x2c),(void **)&stack0xffffffb0,param_1,&pcStack_40,
             (QMetaObject *)staticMetaObject_exref);
  bVar2 = QQmlComponent::isError(*(QQmlComponent **)(param_1 + 0x2c));
  if (bVar2) {
    QQmlComponent::errors(*(QQmlComponent **)(param_1 + 0x2c));
    local_c = (void *)0x1;
    iVar1 = *(int *)(unaff_EBP + 0xc);
    pDVar9 = unaff_EBP;
    for (pQVar10 = (QQmlError *)(unaff_EBP + (*(int *)(unaff_EBP + 8) + 4) * 4);
        pQVar10 != (QQmlError *)(unaff_EBP + (iVar1 + 4) * 4); pQVar10 = pQVar10 + 4) {
      QQmlError::line(pQVar10);
      iVar5 = QQmlError::url(pQVar10);
      puStack_80 = &stack0xffffff84;
      uStack_10 = CONCAT31(uStack_10._1_3_,2);
      pQVar3 = (QMessageLogger *)
               QMessageLogger::QMessageLogger
                         ((QMessageLogger *)&pcStack_40,(char *)0x0,0,(char *)0x0);
      QMessageLogger::warning(pQVar3);
      pQVar4 = (QDebug *)operator<<(&stack0xffffffac);
      pvStack_14._0_1_ = 3;
      pQVar4 = QDebug::operator<<(pQVar4,iVar5);
      *(int *)(*(int *)pQVar4 + 0xc) = *(int *)(*(int *)pQVar4 + 0xc) + 1;
      puStack_80 = (undefined1 *)0x10006075;
      operator<<();
      QDebug::~QDebug((QDebug *)&stack0xffffffa8);
      pvStack_14._0_1_ = 2;
      QDebug::~QDebug((QDebug *)&stack0xffffffac);
      pvStack_14 = (void *)CONCAT31(pvStack_14._1_3_,1);
      QUrl::~QUrl((QUrl *)&stack0xffffffb0);
      pDVar9 = unaff_EDI;
    }
    local_c = (void *)0xffffffff;
    if (*(int *)pDVar9 == 0) {
LAB_100060d4:
      iVar1 = *(int *)(pDVar9 + 8);
      this = pDVar9 + (*(int *)(pDVar9 + 0xc) + 4) * 4;
      while (pDVar9 + (iVar1 + 4) * 4 != this) {
        this = this + -4;
        QQmlError::~QQmlError((QQmlError *)this);
      }
      QListData::dispose(pDVar9);
      ExceptionList = pvStack_14;
      return;
    }
    if (*(int *)pDVar9 != -1) {
      LOCK();
      iVar1 = *(int *)pDVar9;
      *(int *)pDVar9 = iVar1 + -1;
      UNLOCK();
      pDVar9 = unaff_EBP;
      if (iVar1 + -1 == 0) goto LAB_100060d4;
    }
  }
  else {
    pQVar6 = (QObject *)(**(code **)(*(int *)*(QQmlComponent **)(param_1 + 0x2c) + 0x2c))();
    bVar2 = QQmlComponent::isError(*(QQmlComponent **)(param_1 + 0x2c));
    if (bVar2) {
      QQmlComponent::errors(*(QQmlComponent **)(param_1 + 0x2c));
      uStack_10 = 4;
      iVar1 = *(int *)(unaff_ESI + 0xc);
      for (pQVar10 = (QQmlError *)(unaff_ESI + (*(int *)(unaff_ESI + 8) + 4) * 4);
          pQVar10 != (QQmlError *)(unaff_ESI + (iVar1 + 4) * 4); pQVar10 = pQVar10 + 4) {
        QQmlError::line(pQVar10);
        iVar5 = QQmlError::url(pQVar10);
        ppuVar11 = &puStack_80;
        pvStack_14 = (void *)CONCAT31(pvStack_14._1_3_,5);
        pQVar3 = (QMessageLogger *)
                 QMessageLogger::QMessageLogger(aQStack_44,(char *)0x0,0,(char *)0x0);
        QMessageLogger::warning(pQVar3);
        pQVar4 = (QDebug *)operator<<(&stack0xffffffa8,ppuVar11);
        pvStack_18._0_1_ = 6;
        puStack_80 = (undefined1 *)0x100061c2;
        pQVar4 = QDebug::operator<<(pQVar4,iVar5);
        *(int *)(*(int *)pQVar4 + 0xc) = *(int *)(*(int *)pQVar4 + 0xc) + 1;
        puStack_80 = &stack0xffffffac;
        operator<<();
        QDebug::~QDebug((QDebug *)&stack0xffffffac);
        pvStack_18._0_1_ = 5;
        QDebug::~QDebug((QDebug *)&stack0xffffffa8);
        pvStack_18 = (void *)CONCAT31(pvStack_18._1_3_,4);
        QUrl::~QUrl((QUrl *)&stack0xffffffa4);
      }
      uStack_10 = 0xffffffff;
      FUN_10003450((undefined4 *)&stack0xffffffa8);
      ExceptionList = pvStack_18;
      return;
    }
    pQVar7 = QMetaObject::cast((QMetaObject *)staticMetaObject_exref,pQVar6);
    *(QObject **)(param_1 + 0x30) = pQVar7;
    if (pQVar7 == (QObject *)0x0) {
      pQVar3 = (QMessageLogger *)
               QMessageLogger::QMessageLogger(aQStack_28,(char *)0x0,0,(char *)0x0);
      pQVar4 = (QDebug *)QMessageLogger::warning(pQVar3);
      uStack_10 = 7;
      QDebug::operator<<(pQVar4,"Root Item Is Not an QQuickItem");
      uStack_10 = 0xffffffff;
      QDebug::~QDebug(local_4c);
      if (pQVar6 != (QObject *)0x0) {
        (**(code **)(*(int *)pQVar6 + 0xc))();
        ExceptionList = pvStack_1c;
        return;
      }
    }
    else {
      pQVar8 = QQuickWindow::contentItem(*(QQuickWindow **)(param_1 + 0x24));
      QQuickItem::setParentItem(*(QQuickItem **)(param_1 + 0x30),pQVar8);
      FUN_100063f0((int)param_1);
      param_1[0x44] = (QObject)0x1;
      FUN_10002cd0(*(void **)(param_1 + 0xc),*(undefined4 *)(param_1 + 0x38));
      FUN_10005a40((int)param_1);
      QElapsedTimer::start(*(QElapsedTimer **)(param_1 + 0x34));
    }
  }
  ExceptionList = pvStack_14;
  return;
}



void __thiscall FUN_100062f0(void *this,QString *param_1)

{
  bool bVar1;
  QQmlComponent *this_00;
  QUrl *pQVar2;
  QQmlComponent *pQVar3;
  QUrl local_14 [4];
  QQmlComponent *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011e45;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  this_00 = (QQmlComponent *)operator_new(8);
  local_4 = 0;
  local_10 = this_00;
  if (this_00 == (QQmlComponent *)0x0) {
    pQVar3 = (QQmlComponent *)0x0;
  }
  else {
    pQVar2 = (QUrl *)QUrl::QUrl(local_14,param_1,0);
    local_4 = CONCAT31(local_4._1_3_,1);
    QQmlComponent::QQmlComponent(this_00,*(QQmlEngine **)((int)this + 0x28),pQVar2,(QObject *)0x0);
    *(undefined ***)this_00 = QQmlComponent::vftable;
    pQVar3 = this_00;
  }
  *(QQmlComponent **)((int)this + 0x2c) = pQVar3;
  local_4 = 0xffffffff;
  if (this_00 != (QQmlComponent *)0x0) {
    QUrl::~QUrl(local_14);
  }
  bVar1 = QQmlComponent::isLoading(*(QQmlComponent **)((int)this + 0x2c));
  if (bVar1) {
    FUN_10002de0((QObject *)&param_1,*(void ***)((int)this + 0x2c),statusChanged_exref,(void **)this
                 ,FUN_10005f20,0,(int *)0x0);
    QMetaObject::Connection::~Connection((Connection *)&param_1);
    ExceptionList = local_c;
    return;
  }
  FUN_10005f20((QObject *)this);
  ExceptionList = local_c;
  return;
}



void __fastcall FUN_100063f0(int param_1)

{
  int iVar1;
  int iVar2;
  double local_10;
  double local_8;
  
  local_8 = (double)*(int *)(*(int *)(param_1 + 0xc) + 0x28);
  local_10 = (double)*(int *)(*(int *)(param_1 + 0xc) + 0x24);
  QQuickItem::setSize(*(QQuickItem **)(param_1 + 0x30),(QSizeF *)&local_10);
  iVar1 = FUN_10001740(*(int *)(*(int *)(param_1 + 0xc) + 0x28));
  iVar2 = FUN_10001740(*(int *)(*(int *)(param_1 + 0xc) + 0x24));
  QWindow::setGeometry(*(QWindow **)(param_1 + 0x24),0,0,iVar2,iVar1);
  return;
}



int __thiscall FUN_10006460(void *this,int *param_1)

{
  int iVar1;
  int iVar2;
  int *piVar3;
  int iVar4;
  void *pvStack_4;
  
                    // WARNING: Load size is inaccurate
  pvStack_4 = this;
  if ((**this != 1) && (**this != 0)) {
    FUN_100065a0((int *)this);
  }
  piVar3 = param_1;
                    // WARNING: Load size is inaccurate
  if (*(int *)(*this + 0xc) != 0) {
    iVar4 = 0;
    iVar1 = *(int *)(*this + 0xc);
    do {
      if (*(int *)(iVar1 + 0xc) < *param_1) {
        iVar2 = *(int *)(iVar1 + 8);
      }
      else {
        iVar2 = *(int *)(iVar1 + 4);
        iVar4 = iVar1;
      }
      iVar1 = iVar2;
    } while (iVar2 != 0);
    if ((iVar4 != 0) && (*(int *)(iVar4 + 0xc) <= *param_1)) {
      return iVar4 + 0x10;
    }
  }
  param_1 = (int *)0x0;
  piVar3 = FUN_10006620(this,(int *)&pvStack_4,piVar3,&param_1);
  return *piVar3 + 0x10;
}



QMapNodeBase * __thiscall FUN_100064e0(void *this,void *param_1)

{
  QMapNodeBase *pQVar1;
  QMapNodeBase *pQVar2;
  
  pQVar1 = FUN_10006560(param_1,(undefined4 *)((int)this + 0xc),(undefined4 *)((int)this + 0x10),
                        (QMapNodeBase *)0x0,false);
                    // WARNING: Load size is inaccurate
  if ((*this & 1) == 0) {
    *(uint *)pQVar1 = *(uint *)pQVar1 & 0xfffffffe;
  }
  else {
    *(uint *)pQVar1 = *(uint *)pQVar1 | 1;
  }
  if (*(void **)((int)this + 4) == (void *)0x0) {
    *(undefined4 *)(pQVar1 + 4) = 0;
  }
  else {
    pQVar2 = FUN_100064e0(*(void **)((int)this + 4),param_1);
    *(QMapNodeBase **)(pQVar1 + 4) = pQVar2;
    *(uint *)pQVar2 = *(uint *)pQVar2 & 3 | (uint)pQVar1;
  }
  if (*(void **)((int)this + 8) != (void *)0x0) {
    pQVar2 = FUN_100064e0(*(void **)((int)this + 8),param_1);
    *(QMapNodeBase **)(pQVar1 + 8) = pQVar2;
    *(uint *)pQVar2 = *(uint *)pQVar2 & 3 | (uint)pQVar1;
    return pQVar1;
  }
  *(undefined4 *)(pQVar1 + 8) = 0;
  return pQVar1;
}



QMapNodeBase * __thiscall
FUN_10006560(void *this,undefined4 *param_1,undefined4 *param_2,QMapNodeBase *param_3,bool param_4)

{
  QMapNodeBase *pQVar1;
  
  pQVar1 = QMapDataBase::createNode((QMapDataBase *)this,0x14,4,param_3,param_4);
  if (pQVar1 + 0xc != (QMapNodeBase *)0x0) {
    *(undefined4 *)(pQVar1 + 0xc) = *param_1;
  }
  if (pQVar1 + 0x10 != (QMapNodeBase *)0x0) {
    *(undefined4 *)(pQVar1 + 0x10) = *param_2;
  }
  return pQVar1;
}



void __fastcall FUN_100065a0(int *param_1)

{
  int iVar1;
  int *piVar2;
  QMapDataBase *this;
  QMapDataBase *this_00;
  QMapNodeBase *pQVar3;
  
  this_00 = QMapDataBase::createData();
  if (*(void **)(*param_1 + 0xc) != (void *)0x0) {
    pQVar3 = FUN_100064e0(*(void **)(*param_1 + 0xc),this_00);
    *(QMapNodeBase **)(this_00 + 0xc) = pQVar3;
    *(uint *)pQVar3 = *(uint *)pQVar3 & 3 | (uint)(this_00 + 8);
  }
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) goto LAB_10006605;
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) goto LAB_10006605;
  }
  this = (QMapDataBase *)*param_1;
  if (*(QMapNodeBase **)(this + 0xc) != (QMapNodeBase *)0x0) {
    QMapDataBase::freeTree(this,*(QMapNodeBase **)(this + 0xc),4);
  }
  QMapDataBase::freeData(this);
LAB_10006605:
  *param_1 = (int)this_00;
                    // WARNING: Could not recover jumptable at 0x1000660b. Too many branches
                    // WARNING: Treating indirect jump as call
  QMapDataBase::recalcMostLeftNode(this_00);
  return;
}



int * __thiscall FUN_10006620(void *this,int *param_1,int *param_2,undefined4 *param_3)

{
  void *this_00;
  int iVar1;
  QMapNodeBase *pQVar2;
  QMapNodeBase *pQVar3;
  QMapNodeBase *pQVar4;
  bool local_4;
  
                    // WARNING: Load size is inaccurate
  if ((**this != 1) && (**this != 0)) {
    FUN_100065a0((int *)this);
  }
                    // WARNING: Load size is inaccurate
  this_00 = *this;
  pQVar4 = (QMapNodeBase *)0x0;
  local_4 = true;
  pQVar3 = (QMapNodeBase *)((int)this_00 + 8);
  if (*(QMapNodeBase **)((int)this_00 + 0xc) != (QMapNodeBase *)0x0) {
    iVar1 = *param_2;
    pQVar2 = *(QMapNodeBase **)((int)this_00 + 0xc);
    do {
      pQVar3 = pQVar2;
      if (*(int *)(pQVar3 + 0xc) < iVar1) {
        pQVar2 = *(QMapNodeBase **)(pQVar3 + 8);
      }
      else {
        pQVar2 = *(QMapNodeBase **)(pQVar3 + 4);
        pQVar4 = pQVar3;
      }
      local_4 = *(int *)(pQVar3 + 0xc) >= iVar1;
    } while (pQVar2 != (QMapNodeBase *)0x0);
    if ((pQVar4 != (QMapNodeBase *)0x0) && (*(int *)(pQVar4 + 0xc) <= iVar1)) {
      *(undefined4 *)(pQVar4 + 0x10) = *param_3;
      *param_1 = (int)pQVar4;
      return param_1;
    }
  }
  pQVar3 = FUN_10006560(this_00,param_2,param_3,pQVar3,local_4);
  *param_1 = (int)pQVar3;
  return param_1;
}



void FUN_100066b0(void)

{
  undefined4 *puVar1;
  int local_4;
  
  if (*(int *)(DAT_100225f0 + 4) == 0) {
    local_4 = 1;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 2;
    *puVar1 = 0x30;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 3;
    *puVar1 = 0x31;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 4;
    *puVar1 = 0x32;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 5;
    *puVar1 = 0x33;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 6;
    *puVar1 = 0x34;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 7;
    *puVar1 = 0x35;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 8;
    *puVar1 = 0x36;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 9;
    *puVar1 = 0x37;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 10;
    *puVar1 = 0x38;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xb;
    *puVar1 = 0x39;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xc;
    *puVar1 = 0x41;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xd;
    *puVar1 = 0x42;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xe;
    *puVar1 = 0x43;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xf;
    *puVar1 = 0x44;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x10;
    *puVar1 = 0x45;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x11;
    *puVar1 = 0x46;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x12;
    *puVar1 = 0x47;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x13;
    *puVar1 = 0x48;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x14;
    *puVar1 = 0x49;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x15;
    *puVar1 = 0x4a;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x16;
    *puVar1 = 0x4b;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x17;
    *puVar1 = 0x4c;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x18;
    *puVar1 = 0x4d;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x19;
    *puVar1 = 0x4e;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x1a;
    *puVar1 = 0x4f;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x1b;
    *puVar1 = 0x50;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    *puVar1 = 0x51;
    local_4 = 0x1c;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x1d;
    *puVar1 = 0x52;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x1e;
    *puVar1 = 0x53;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x1f;
    *puVar1 = 0x54;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x20;
    *puVar1 = 0x55;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x21;
    *puVar1 = 0x56;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x22;
    *puVar1 = 0x57;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x23;
    *puVar1 = 0x58;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x24;
    *puVar1 = 0x59;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x25;
    *puVar1 = 0x5a;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x26;
    *puVar1 = 0x30;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x27;
    *puVar1 = 0x31;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x28;
    *puVar1 = 0x32;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x29;
    *puVar1 = 0x33;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x2a;
    *puVar1 = 0x34;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x2b;
    *puVar1 = 0x35;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x2c;
    *puVar1 = 0x36;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x2d;
    *puVar1 = 0x37;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x2e;
    *puVar1 = 0x38;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x2f;
    *puVar1 = 0x39;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x30;
    *puVar1 = 0x2f;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x31;
    *puVar1 = 0x2a;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x32;
    *puVar1 = 0x2d;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x33;
    *puVar1 = 0x2b;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x34;
    *puVar1 = 0x1000005;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x35;
    *puVar1 = 0x2e;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x36;
    *puVar1 = 0x5b;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    *puVar1 = 0x5d;
    local_4 = 0x37;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x38;
    *puVar1 = 0x3b;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x39;
    *puVar1 = 0x27;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x3a;
    *puVar1 = 0x7e;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x3b;
    *puVar1 = 0x2c;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x3c;
    *puVar1 = 0x2e;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x3d;
    *puVar1 = 0x2f;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x3e;
    *puVar1 = 0x5c;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x3f;
    *puVar1 = 0x2d;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x40;
    *puVar1 = 0x3d;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x41;
    *puVar1 = 0x1000005;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x42;
    *puVar1 = 0x20;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x43;
    *puVar1 = 0x1000003;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x44;
    *puVar1 = 0x1000001;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x45;
    *puVar1 = 0x1000024;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x46;
    *puVar1 = 0x1000025;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x47;
    *puVar1 = 0x1000000;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x48;
    *puVar1 = 0x1000026;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x49;
    *puVar1 = 0x1000006;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x4a;
    *puVar1 = 0x1000007;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x4b;
    *puVar1 = 0x1000010;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x4c;
    *puVar1 = 0x1000011;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x4d;
    *puVar1 = 0x1000016;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x4e;
    *puVar1 = 0x1000017;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x4f;
    *puVar1 = 0x1000008;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x50;
    *puVar1 = 0x1000020;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x51;
    *puVar1 = 0x1000020;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    *puVar1 = 0x1000023;
    local_4 = 0x52;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x53;
    *puVar1 = 0x1000023;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x54;
    *puVar1 = 0x1000021;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x55;
    *puVar1 = 0x1000021;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x56;
    *puVar1 = 0x1000022;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x57;
    *puVar1 = 0x1000022;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x58;
    *puVar1 = 0x1000055;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x59;
    *puVar1 = 0x1000013;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x5a;
    *puVar1 = 0x1000012;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x5b;
    *puVar1 = 0x1000015;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x5c;
    *puVar1 = 0x1000014;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x5d;
    *puVar1 = 0x1000030;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x5e;
    *puVar1 = 0x1000031;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x5f;
    *puVar1 = 0x1000032;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x60;
    *puVar1 = 0x1000033;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x61;
    *puVar1 = 0x1000034;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x62;
    *puVar1 = 0x1000035;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 99;
    *puVar1 = 0x1000036;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 100;
    *puVar1 = 0x1000037;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x65;
    *puVar1 = 0x1000038;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x66;
    *puVar1 = 0x1000039;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x67;
    *puVar1 = 0x100003a;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x6b;
    *puVar1 = 0x100003b;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x6c;
    *puVar1 = 1;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x6d;
    *puVar1 = 2;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x6e;
    *puVar1 = 4;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x6f;
    *puVar1 = 8;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    *puVar1 = 0x10;
    local_4 = 0x92;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x95;
    *puVar1 = 0x1000013;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x94;
    *puVar1 = 0x1000012;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x93;
    *puVar1 = 0x1000015;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x72;
    *puVar1 = 0x1000014;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x73;
    *puVar1 = 0x1000005;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x76;
    *puVar1 = 0x1000003;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0x77;
    *puVar1 = 0x41;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xaf;
    *puVar1 = 0x44;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xb1;
    *puVar1 = 0x1000013;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xb2;
    *puVar1 = 0x1000015;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xb0;
    *puVar1 = 0x1000012;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xab;
    *puVar1 = 0x1000014;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xac;
    *puVar1 = 0x1000005;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xc9;
    *puVar1 = 0x1000003;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    local_4 = 0xca;
    *puVar1 = 0x41;
    puVar1 = (undefined4 *)FUN_10006460(&DAT_100225f0,&local_4);
    *puVar1 = 0x44;
  }
  return;
}



undefined4 __cdecl FUN_100073e0(undefined4 param_1)

{
  undefined4 uVar1;
  
  uVar1 = 0;
  switch(param_1) {
  case 0x1000020:
    return 0x2000000;
  case 0x1000021:
    return 0x4000000;
  case 0x1000022:
    uVar1 = 0x10000000;
    break;
  case 0x1000023:
    return 0x8000000;
  }
  return uVar1;
}



undefined4 __cdecl FUN_10007430(int param_1)

{
  int iVar1;
  int iVar2;
  undefined4 *puVar3;
  int iVar4;
  
  FUN_100066b0();
  if (*(int *)(DAT_100225f0 + 0xc) != 0) {
    iVar4 = 0;
    iVar1 = *(int *)(DAT_100225f0 + 0xc);
    do {
      if (*(int *)(iVar1 + 0xc) < param_1) {
        iVar2 = *(int *)(iVar1 + 8);
      }
      else {
        iVar2 = *(int *)(iVar1 + 4);
        iVar4 = iVar1;
      }
      iVar1 = iVar2;
    } while (iVar2 != 0);
    if ((iVar4 != 0) && (*(int *)(iVar4 + 0xc) <= param_1)) {
      puVar3 = (undefined4 *)FUN_10006460(&DAT_100225f0,&param_1);
      return *puVar3;
    }
  }
  return 0x1ffffff;
}



void * __thiscall FUN_10007480(void *this,undefined4 param_1)

{
  *(undefined4 *)((int)this + 4) = param_1;
  *(undefined ***)this = BlackMesaUINetworkAccessManagerFactory::vftable;
  return this;
}



void * __thiscall FUN_100074a0(void *this,QNetworkRequest *param_1,int param_2)

{
  undefined4 *puVar1;
  int iVar2;
  QNetworkRequest *this_00;
  int *piVar3;
  QUrl *pQVar4;
  QString *pQVar5;
  QByteArray *this_01;
  undefined4 uVar6;
  QMessageLogger *this_02;
  QDebug *this_03;
  QVariant *pQVar7;
  char *pcStack_70;
  QByteArray **ppQStack_6c;
  QImage **ppQStack_68;
  int iStack_60;
  undefined1 *puStack_5c;
  undefined4 uStack_58;
  undefined4 *puStack_54;
  void *pvVar8;
  int *_OpenFlag;
  uint uStack_48;
  undefined4 auStack_34 [2];
  undefined1 uStack_2c;
  void *local_28;
  QString aQStack_24 [4];
  QTypedArrayData<> *apQStack_20 [2];
  undefined1 uStack_18;
  QUrl aQStack_10 [4];
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &_OpenFlag_10011eba;
  local_c = ExceptionList;
  uStack_48 = DAT_10022088 ^ (uint)&stack0xffffffbc;
  ExceptionList = &local_c;
  local_28 = this;
  QNetworkReply::QNetworkReply((QNetworkReply *)this,(QObject *)0x0);
  puVar1 = (undefined4 *)((int)this + 0x10);
  uStack_4 = 0;
  *(undefined ***)this = BlackMesaUINetworkReply::vftable;
  *(undefined4 *)((int)this + 8) = 0;
  *puVar1 = 0;
  *(undefined4 *)((int)this + 0x14) = 0;
  *(int *)((int)this + 0x18) = param_2;
  piVar3 = (int *)FUN_100042b0(param_2);
  this_00 = param_1;
  QNetworkReply::setRequest((QNetworkReply *)this,param_1);
  _OpenFlag = &param_2;
  pQVar4 = (QUrl *)QNetworkRequest::url(this_00);
  puStack_8._0_1_ = 1;
  puStack_54 = (undefined4 *)0x10007530;
  QNetworkReply::setUrl((QNetworkReply *)this,pQVar4);
  puStack_8 = (undefined1 *)((uint)puStack_8._1_3_ << 8);
  QUrl::~QUrl((QUrl *)&param_1);
  puStack_54 = (undefined4 *)0x1000754b;
  QNetworkReply::setOperation((QNetworkReply *)this,2);
  pvVar8 = (void *)0x1;
  puStack_54 = (undefined4 *)0x1000755c;
  QIODevice::open((char *)0x1,(int)_OpenFlag);
  puStack_54 = &uStack_4;
  uStack_58 = 0x10007569;
  pQVar4 = (QUrl *)QNetworkReply::url((QNetworkReply *)this);
  aQStack_10[0] = (QUrl)0x2;
  uStack_58 = 0x7f00000;
  puStack_5c = &stack0xffffffc0;
  iStack_60 = 0x10007584;
  QUrl::path(pQVar4);
  uStack_18 = 4;
  iStack_60 = 0x1000758f;
  QUrl::~QUrl(aQStack_10);
  iStack_60 = *(int *)(uStack_48 + 4) + -1;
  ppQStack_68 = (QImage **)0x100075a7;
  pQVar5 = (QString *)QString::right((QString *)&uStack_48,(int)&local_c);
  ppQStack_68 = (QImage **)0x100075b2;
  QString::operator=((QString *)&stack0xffffffb4,pQVar5);
  QString::~QString((QString *)aQStack_10);
  ppQStack_68 = (QImage **)0x100075cb;
  this_01 = (QByteArray *)QString::toLocal8Bit((QString *)&stack0xffffffb4);
  iVar2 = *piVar3;
  ppQStack_68 = &param_1_10015194;
  ppQStack_6c = &this_1001519c;
  apQStack_20[0] = (QTypedArrayData<> *)CONCAT31(apQStack_20[0]._1_3_,5);
  pcStack_70 = (char *)0x100075e5;
  pcStack_70 = QByteArray::constData(this_01);
  uVar6 = (**(code **)(iVar2 + 0xa4))();
  *(undefined4 *)((int)this + 8) = uVar6;
  uStack_2c = 4;
  QByteArray::~QByteArray((QByteArray *)apQStack_20);
  if (*(int *)((int)this + 8) == 0) {
    apQStack_20[0] = QString::fromAscii_helper("VFS, Error Opening %1",0x15);
    uStack_58 = CONCAT31(uStack_58._1_3_,0x20);
    uStack_2c = 6;
    QChar::QChar((QChar *)&stack0xffffff8c);
    pQVar5 = (QString *)QString::arg(aQStack_24,&uStack_58,&iStack_60,0);
    QNetworkReply::setError((QNetworkReply *)this,0xcb,pQVar5);
    QString::~QString((QString *)&ppQStack_68);
    QString::~QString((QString *)auStack_34);
    auStack_34[0] = 0xcb;
    QMetaObject::invokeMethod
              (this,"error",2,0,0,auStack_34,"QNetworkReply::NetworkError",0,0,0,0,0,0,0,0,0,0,0,0,0
               ,0,0,0,0,0);
    pQVar5 = (QString *)QIODevice::errorString((QIODevice *)this);
    this_02 = (QMessageLogger *)
              QMessageLogger::QMessageLogger((QMessageLogger *)&iStack_60,(char *)0x0,0,(char *)0x0)
    ;
    this_03 = (QDebug *)QMessageLogger::debug(this_02);
    uStack_48._0_1_ = (QString)0x9;
    QDebug::operator<<(this_03,pQVar5);
    uStack_48._0_1_ = (QString)0x8;
    QDebug::~QDebug((QDebug *)&stack0xffffffc4);
    uStack_48 = CONCAT31(uStack_48._1_3_,4);
    QString::~QString((QString *)&pcStack_70);
    QNetworkReply::setFinished((QNetworkReply *)this,true);
    QMetaObject::invokeMethod(this,"finished",2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  }
  else {
    uVar6 = (**(code **)(*piVar3 + 0xb4))();
    *(undefined4 *)((int)this + 0x14) = 0;
    *puVar1 = uVar6;
    pQVar7 = (QVariant *)
             QVariant::QVariant((QVariant *)&stack0xffffff9c,
                                CONCAT44(*(undefined4 *)((int)this + 0x14),uVar6));
    uStack_48._0_1_ = (QString)0xa;
    QNetworkReply::setHeader((QNetworkReply *)this,1,pQVar7);
    uStack_48 = CONCAT31(uStack_48._1_3_,4);
    QVariant::~QVariant((QVariant *)&stack0xffffff9c);
    QMetaObject::invokeMethod(this,"metaDataChanged",2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
    QMetaObject::invokeMethod
              (this,"downloadProgress",2,0,0,puVar1,"qint64",puVar1,"qint64",0,0,0,0,0,0,0,0,0,0,0,0
               ,0,0,0,0);
    QMetaObject::invokeMethod(this,"readyRead",2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
    QNetworkReply::setFinished((QNetworkReply *)this,true);
    QMetaObject::invokeMethod(this,"finished",2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  }
  uStack_48 = uStack_48 & 0xffffff00;
  QString::~QString((QString *)&stack0xffffff88);
  ExceptionList = pvVar8;
  return this;
}



void * __thiscall FUN_100078e0(void *this,byte param_1)

{
  QNetworkAccessManager::~QNetworkAccessManager((QNetworkAccessManager *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10007900(void *this,byte param_1)

{
  QQmlNetworkAccessManagerFactory::~QQmlNetworkAccessManagerFactory
            ((QQmlNetworkAccessManagerFactory *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void * __thiscall FUN_10007920(void *this,byte param_1)

{
  QNetworkReply::~QNetworkReply((QNetworkReply *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void __fastcall FUN_10007940(int *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10007942. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(*param_1 + 0x34))();
  return;
}



longlong __fastcall FUN_10007950(QIODevice *param_1)

{
  uint uVar1;
  int iVar2;
  int *piVar3;
  uint uVar4;
  __int64 _Var5;
  
  piVar3 = (int *)FUN_100042b0(*(int *)(param_1 + 0x18));
  if (*(int *)(param_1 + 8) == 0) {
                    // WARNING: Could not recover jumptable at 0x10007967. Too many branches
                    // WARNING: Treating indirect jump as call
    _Var5 = QIODevice::bytesAvailable(param_1);
    return _Var5;
  }
  uVar4 = (**(code **)(*piVar3 + 0xb0))(*(int *)(param_1 + 8));
  uVar1 = *(uint *)(param_1 + 0x10);
  iVar2 = *(int *)(param_1 + 0x14);
  _Var5 = QIODevice::bytesAvailable(param_1);
  return _Var5 + CONCAT44(iVar2 - (uint)(uVar1 < uVar4),uVar1 - uVar4);
}



void __fastcall FUN_100079a0(int param_1)

{
  int *piVar1;
  int unaff_EDI;
  
  piVar1 = (int *)FUN_100042b0(*(int *)(param_1 + 0x18));
  QNetworkReply::close(unaff_EDI);
  if (*(int *)(param_1 + 8) != 0) {
    (**(code **)(*piVar1 + 0xa8))(*(int *)(param_1 + 8));
    *(undefined4 *)(param_1 + 8) = 0;
  }
  return;
}



QNetworkAccessManager * __fastcall FUN_100079e0(int param_1)

{
  undefined4 uVar1;
  QNetworkAccessManager *this;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10011eeb;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  this = (QNetworkAccessManager *)operator_new(0xc);
  local_4 = 0;
  if (this != (QNetworkAccessManager *)0x0) {
    uVar1 = *(undefined4 *)(param_1 + 4);
    QNetworkAccessManager::QNetworkAccessManager(this,(QObject *)0x0);
    *(undefined ***)this = BlackMesaUINetworkAccessManager::vftable;
    *(undefined4 *)(this + 8) = uVar1;
    ExceptionList = local_c;
    return this;
  }
  ExceptionList = local_c;
  return (QNetworkAccessManager *)0x0;
}



QNetworkReply * __thiscall FUN_10007a70(void *this,QIODevice *param_1,QNetworkRequest *param_2)

{
  bool bVar1;
  QUrl *this_00;
  QString *this_01;
  QNetworkReply *pQVar2;
  void *this_02;
  void *unaff_EBX;
  void *local_c;
  undefined1 *puStack_8;
  Operation OStack_4;
  
  OStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011f2d;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  this_00 = (QUrl *)QNetworkRequest::url(param_2);
  puStack_8 = (undefined1 *)0x0;
  this_01 = (QString *)QUrl::scheme(this_00);
  local_c._0_1_ = 1;
  bVar1 = QString::operator!=(this_01,(char *)&this_10015200);
  local_c = (void *)((uint)local_c._1_3_ << 8);
  QString::~QString((QString *)&stack0x00000000);
  local_c = (void *)0xffffffff;
  QUrl::~QUrl((QUrl *)&stack0xffffffe8);
  if (bVar1) {
    pQVar2 = QNetworkAccessManager::createRequest
                       ((QNetworkAccessManager *)this,OStack_4,param_2,param_1);
    ExceptionList = unaff_EBX;
    return pQVar2;
  }
  this_02 = operator_new(0x20);
  local_c = (void *)0x2;
  if (this_02 != (void *)0x0) {
    pQVar2 = (QNetworkReply *)FUN_100074a0(this_02,param_2,*(int *)((int)this + 8));
    ExceptionList = unaff_EBX;
    return pQVar2;
  }
  ExceptionList = unaff_EBX;
  return (QNetworkReply *)0x0;
}



undefined1 FUN_10007b70(void)

{
  return 1;
}



undefined8 __thiscall FUN_10007b80(void *this,int param_1,undefined4 param_2)

{
  uint uVar1;
  int *piVar2;
  int iVar3;
  longlong lVar4;
  QVariant aQStack_2c [16];
  QVariant aQStack_1c [16];
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011f62;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffc4;
  ExceptionList = &local_c;
  piVar2 = (int *)FUN_100042b0(*(int *)((int)this + 0x18));
  if (*(int *)((int)this + 8) == 0) {
LAB_10007bba:
    iVar3 = -1;
    param_1 = -1;
  }
  else {
    iVar3 = (**(code **)(*piVar2 + 0x9c))(param_1,param_2,*(int *)((int)this + 8),uVar1);
                    // WARNING: Load size is inaccurate
    puStack_8 = (undefined1 *)(iVar3 >> 0x1f);
    lVar4 = (**(code **)(*this + 0x4c))();
    if (lVar4 == 0) {
      (**(code **)(*piVar2 + 0xa8))(*(undefined4 *)((int)this + 8));
      *(undefined4 *)((int)this + 8) = 0;
    }
    if (iVar3 == 0 && param_1 == 0) {
                    // WARNING: Load size is inaccurate
      lVar4 = (**(code **)(*this + 0x4c))();
      if (lVar4 == 0) goto LAB_10007bba;
    }
    QVariant::QVariant(aQStack_2c,200);
    uStack_4 = 0;
    QNetworkReply::setAttribute((QNetworkReply *)this,0,aQStack_2c);
    uStack_4 = 0xffffffff;
    QVariant::~QVariant(aQStack_2c);
    QVariant::QVariant(aQStack_1c,2,&param_1_100151f0);
    uStack_4 = 1;
    QNetworkReply::setAttribute((QNetworkReply *)this,1,aQStack_1c);
    uStack_4 = 0xffffffff;
    QVariant::~QVariant(aQStack_1c);
  }
  ExceptionList = local_c;
  return CONCAT44(param_1,iVar3);
}



undefined8 __fastcall FUN_10007ca0(int param_1)

{
  return *(undefined8 *)(param_1 + 0x10);
}



void __cdecl FUN_10007cb0(int param_1,int param_2,int param_3,int param_4,QJsonValue *param_5)

{
  int iVar1;
  code *pcVar2;
  void **ppvVar3;
  bool bVar4;
  int *piVar5;
  int iVar6;
  int iVar7;
  int unaff_retaddr;
  int local_5c;
  int local_58;
  int iStack_54;
  int iStack_50;
  undefined4 uStack_4c;
  int iStack_48;
  int local_3c;
  int local_38;
  int local_34;
  int local_30 [3];
  QJsonValue aQStack_24 [24];
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10011f92;
  piVar5 = (int *)(DAT_10022088 ^ (uint)&stack0xffffff94);
  iVar1 = param_3 * 2;
  ppvVar3 = &local_c;
  iVar7 = param_3;
  local_c = ExceptionList;
  pcVar2 = operator=_exref;
  while (ExceptionList = ppvVar3, iVar6 = iVar1 + 2, iVar6 < param_4) {
    local_5c = param_1;
    local_58 = (param_2 + -1 + iVar6) * 2;
    QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_5c);
    puStack_8 = (undefined1 *)0x0;
    iStack_54 = (param_1 + iVar6) * 2;
    piVar5 = local_30;
    QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_58);
    local_c._0_1_ = 1;
    bVar4 = FUN_10009650((QJsonValue *)&local_34);
    local_c = (void *)((uint)local_c._1_3_ << 8);
    QJsonValue::~QJsonValue((QJsonValue *)&local_34);
    local_c = (void *)0xffffffff;
    QJsonValue::~QJsonValue(aQStack_24);
    pcVar2 = operator=_exref;
    if (bVar4) {
      iVar6 = iVar1 + 1;
    }
    iStack_54 = uStack_4;
    uStack_4c = uStack_4;
    iStack_50 = (unaff_retaddr + iVar6) * 2;
    iStack_48 = (unaff_retaddr + iVar7) * 2;
    QJsonValueRef::operator=((QJsonValueRef *)&uStack_4c,(QJsonValueRef *)&iStack_54);
    ppvVar3 = (void **)ExceptionList;
    iVar7 = iVar6;
    iVar1 = iVar6 * 2;
  }
  if (iVar6 == param_4) {
    local_3c = param_1;
    local_34 = param_1;
    local_38 = (param_2 + param_4) * 2 + -2;
    local_30[0] = (param_2 + iVar7) * 2;
    (*pcVar2)(&local_3c,piVar5);
    iVar7 = param_4 + -1;
  }
  FUN_10008660(param_1,param_2,iVar7,param_3,param_5);
  ExceptionList = local_c;
  return;
}



void __cdecl FUN_10007e50(int param_1,int param_2,undefined4 param_3,int param_4)

{
  code *pcVar1;
  int iVar2;
  void **ppvVar3;
  bool bVar4;
  QJsonValue *pQVar5;
  int iVar6;
  int iVar7;
  undefined1 *puVar8;
  int local_a4;
  int iStack_9c;
  int iStack_98;
  int local_94;
  QJsonValue aQStack_90 [4];
  QJsonValue aQStack_8c [16];
  int iStack_7c;
  int local_78;
  int local_74;
  int iStack_68;
  int iStack_64;
  int iStack_60;
  QJsonValue aQStack_5c [16];
  int iStack_4c;
  int iStack_48;
  QJsonValue aQStack_44 [8];
  QJsonValue aQStack_3c [4];
  undefined1 local_38 [24];
  int iStack_20;
  undefined4 auStack_1c [2];
  void *local_14;
  undefined1 *puStack_10;
  undefined4 uStack_c;
  undefined1 uStack_8;
  
  uStack_c = 0xffffffff;
  puStack_10 = &LAB_10011fd7;
  local_14 = ExceptionList;
  pQVar5 = (QJsonValue *)(DAT_10022088 ^ (uint)&stack0xffffff40);
  if (param_2 != param_4) {
    ppvVar3 = &local_14;
    local_94 = param_2;
    pcVar1 = ~QJsonValue_exref;
    for (iVar6 = param_2 + 1; ExceptionList = ppvVar3, iVar6 != param_4; iVar6 = iVar6 + 1) {
      local_74 = iVar6 * 2;
      puVar8 = local_38;
      local_78 = param_1;
      QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_78);
      puStack_10 = (undefined1 *)0x0;
      QJsonValue::QJsonValue((QJsonValue *)&local_94,aQStack_3c);
      puStack_10 = (undefined1 *)CONCAT31(puStack_10._1_3_,2);
      (*pcVar1)(puVar8,pQVar5);
      iStack_68 = param_1;
      iStack_64 = param_2 * 2;
      QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&iStack_68);
      uStack_8 = 3;
      bVar4 = FUN_10009650(aQStack_8c);
      uStack_8 = 2;
      QJsonValue::~QJsonValue(aQStack_44);
      if (bVar4) {
        FUN_10008500(auStack_1c,param_1,param_2,param_1,iVar6,param_1,iVar6 + 1);
        iStack_4c = param_1;
        iStack_48 = param_2 * 2;
        pQVar5 = aQStack_8c;
        QJsonValueRef::operator=((QJsonValueRef *)&iStack_4c,pQVar5);
      }
      else {
        iStack_98 = (iVar6 + -1) * 2;
        pQVar5 = aQStack_5c;
        iStack_9c = iVar6;
        iStack_20 = iVar6;
        QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&iStack_9c);
        uStack_c._0_1_ = 4;
        bVar4 = FUN_10009650(aQStack_90);
        uStack_c = CONCAT31(uStack_c._1_3_,2);
        QJsonValue::~QJsonValue((QJsonValue *)&iStack_60);
        iVar2 = iVar6 + -1;
        local_a4 = param_1;
        if (bVar4) {
          do {
            iVar7 = iVar2;
            local_78 = iVar7 * 2;
            iStack_7c = param_1;
            iStack_64 = param_1;
            iStack_60 = local_a4 * 2;
            QJsonValueRef::operator=((QJsonValueRef *)&iStack_64,(QJsonValueRef *)&iStack_7c);
            iStack_9c = param_1;
            iStack_98 = (iVar7 + -1) * 2;
            pQVar5 = aQStack_5c;
            QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&iStack_9c);
            uStack_c._0_1_ = 4;
            bVar4 = FUN_10009650(aQStack_90);
            uStack_c = CONCAT31(uStack_c._1_3_,2);
            QJsonValue::~QJsonValue((QJsonValue *)&iStack_60);
            iVar2 = iVar7 + -1;
            local_a4 = iVar7;
          } while (bVar4);
        }
        iStack_98 = local_a4;
        local_94 = iVar6 * 2;
        QJsonValueRef::operator=((QJsonValueRef *)&iStack_98,aQStack_90);
      }
      pcVar1 = ~QJsonValue_exref;
      uStack_c = 0xffffffff;
      QJsonValue::~QJsonValue(aQStack_90);
      ppvVar3 = (void **)ExceptionList;
    }
  }
  ExceptionList = local_14;
  return;
}



void __cdecl FUN_100080f0(int param_1,int param_2,undefined4 param_3,int param_4)

{
  void **ppvVar1;
  int iVar2;
  int iVar3;
  int unaff_retaddr;
  int local_34;
  int local_30 [4];
  QJsonValue aQStack_20 [20];
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012012;
  iVar3 = param_4 - param_2;
  iVar2 = iVar3 / 2;
  ppvVar1 = &local_c;
  local_c = ExceptionList;
  while (ExceptionList = ppvVar1, 0 < iVar2) {
    iVar2 = iVar2 + -1;
    local_34 = param_1;
    local_30[0] = (param_2 + iVar2) * 2;
    QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_34);
    puStack_8 = (undefined1 *)0x0;
    QJsonValue::QJsonValue(aQStack_20,(QJsonValue *)local_30);
    puStack_8 = (undefined1 *)CONCAT31(puStack_8._1_3_,2);
    QJsonValue::~QJsonValue((QJsonValue *)local_30);
    FUN_10007cb0(unaff_retaddr,param_1,iVar2,iVar3,aQStack_20);
    puStack_8 = (undefined1 *)0xffffffff;
    QJsonValue::~QJsonValue(aQStack_20);
    ppvVar1 = (void **)ExceptionList;
    param_2 = param_1;
  }
  ExceptionList = local_c;
  return;
}



void __cdecl FUN_100081d0(undefined4 param_1,int param_2,int param_3)

{
  bool bVar1;
  int unaff_retaddr;
  uint uStack_78;
  void *local_6c;
  int local_68;
  int iStack_64;
  QJsonValue aQStack_5c [8];
  QJsonValue aQStack_54 [8];
  QJsonValue aQStack_4c [8];
  QJsonValue aQStack_44 [16];
  QJsonValue aQStack_34 [16];
  void *pvStack_24;
  undefined4 uStack_1c;
  undefined4 uStack_18;
  undefined4 uStack_14;
  int iStack_10;
  void *local_c;
  undefined1 *puStack_8;
  int iStack_4;
  
  iStack_4 = -1;
  puStack_8 = &LAB_10012066;
  local_c = ExceptionList;
  uStack_78 = DAT_10022088 ^ (uint)&stack0xffffff8c;
  ExceptionList = &local_c;
  local_6c = (void *)param_1;
  local_68 = param_2 * 2;
  QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_6c);
  local_68 = param_2;
  iStack_64 = param_3 * 2;
  puStack_8 = (undefined1 *)0x0;
  QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_68);
  local_c._0_1_ = 1;
  bVar1 = FUN_10009650(aQStack_54);
  local_c = (void *)((uint)local_c._1_3_ << 8);
  QJsonValue::~QJsonValue(aQStack_54);
  local_c = (void *)0xffffffff;
  QJsonValue::~QJsonValue(aQStack_44);
  if (bVar1) {
    FUN_10009150(param_1,param_2,iStack_4,unaff_retaddr);
  }
  local_6c = (void *)param_1;
  local_68 = param_2 * 2;
  QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_6c);
  uStack_78 = param_2;
  iStack_10 = 2;
  QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&uStack_78);
  uStack_14._0_1_ = 3;
  bVar1 = FUN_10009650(aQStack_4c);
  uStack_14 = CONCAT31(uStack_14._1_3_,2);
  QJsonValue::~QJsonValue(aQStack_4c);
  uStack_14 = 0xffffffff;
  QJsonValue::~QJsonValue(aQStack_5c);
  if (bVar1) {
    FUN_10009150(param_1,param_2,iStack_4,unaff_retaddr);
    local_6c = local_c;
    local_68 = (int)puStack_8 * 2;
    QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_6c);
    local_68 = (int)puStack_8;
    iStack_64 = iStack_4 * 2;
    uStack_18 = 4;
    QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_68);
    uStack_1c._0_1_ = 5;
    bVar1 = FUN_10009650(aQStack_44);
    uStack_1c = CONCAT31(uStack_1c._1_3_,4);
    QJsonValue::~QJsonValue(aQStack_44);
    uStack_1c = 0xffffffff;
    QJsonValue::~QJsonValue(aQStack_34);
    if (bVar1) {
      FUN_10009150(local_c,(int)puStack_8,uStack_14,iStack_10);
    }
  }
  ExceptionList = pvStack_24;
  return;
}



void __cdecl
FUN_10008430(undefined4 param_1,int param_2,int param_3,int param_4,undefined4 param_5,int param_6)

{
  int iVar1;
  
  if (0x28 < param_6 - param_2) {
    iVar1 = (param_6 - param_2) + 1;
    iVar1 = (int)((iVar1 >> 0x1f & 7U) + iVar1) >> 3;
    FUN_100081d0(param_1,param_2,param_1);
    FUN_100081d0(param_3,param_4 - iVar1,param_3);
    FUN_100081d0(param_5,param_6 + iVar1 * -2,param_5);
    FUN_100081d0(param_1,param_2 + iVar1,param_3);
    return;
  }
  FUN_100081d0(param_1,param_2,param_3);
  return;
}



void __cdecl
FUN_10008500(undefined4 *param_1,undefined4 param_2,int param_3,undefined4 param_4,int param_5,
            undefined4 param_6,int param_7)

{
  undefined4 local_10;
  int local_c;
  undefined4 local_8;
  int local_4;
  
  if (param_3 != param_5) {
    do {
      param_5 = param_5 + -1;
      local_10 = param_4;
      local_c = param_5 * 2;
      param_7 = param_7 + -1;
      local_8 = param_6;
      local_4 = param_7 * 2;
      QJsonValueRef::operator=((QJsonValueRef *)&local_8,(QJsonValueRef *)&local_10);
    } while (param_3 != param_5);
  }
  *param_1 = param_6;
  param_1[1] = param_7;
  return;
}



void __cdecl FUN_10008570(int param_1,int param_2,int param_3,int param_4)

{
  int unaff_retaddr;
  int local_44;
  int local_40;
  int iStack_3c;
  int iStack_38;
  int iStack_34;
  QJsonValue aQStack_30 [16];
  QJsonValue aQStack_20 [16];
  void *pvStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100120a2;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_44 = param_3;
  local_40 = param_4 * 2 + -2;
  QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_44);
  puStack_8 = (undefined1 *)0x0;
  QJsonValue::QJsonValue(aQStack_20,aQStack_30);
  puStack_8 = (undefined1 *)CONCAT31(puStack_8._1_3_,2);
  QJsonValue::~QJsonValue(aQStack_30);
  iStack_3c = param_1 * 2;
  iStack_38 = param_2;
  iStack_34 = (param_3 + -1) * 2;
  QJsonValueRef::operator=((QJsonValueRef *)&iStack_38,(QJsonValueRef *)&local_40);
  FUN_10007cb0(unaff_retaddr,param_1,0,(param_3 + -1) - param_1,aQStack_20);
  puStack_8 = (undefined1 *)0xffffffff;
  QJsonValue::~QJsonValue(aQStack_20);
  ExceptionList = pvStack_10;
  return;
}



void __cdecl
FUN_10008660(undefined4 param_1,int param_2,int param_3,int param_4,QJsonValue *param_5)

{
  bool bVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  undefined4 local_3c;
  int iStack_38;
  undefined4 local_34;
  int local_30;
  undefined4 uStack_2c;
  int iStack_28;
  undefined4 uStack_24;
  int iStack_20;
  QJsonValue local_1c [16];
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100120da;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  bVar1 = false;
  local_3c = 0;
  iVar4 = param_3;
  do {
    iVar3 = (iVar4 + -1) / 2;
    if (param_4 < iVar4) {
      local_34 = param_1;
      local_30 = (param_2 + iVar3) * 2;
      QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_34);
      puStack_8 = (undefined1 *)0x0;
      bVar1 = true;
      bVar2 = FUN_10009650((QJsonValue *)&iStack_20);
      param_2 = CONCAT31(param_2._1_3_,1);
      if (!bVar2) goto LAB_100086f1;
    }
    else {
LAB_100086f1:
      param_3 = 0;
    }
    uStack_4 = 0xffffffff;
    if (bVar1) {
      bVar1 = false;
      QJsonValue::~QJsonValue(local_1c);
    }
    if ((char)param_3 == '\0') {
      local_3c = param_1;
      iStack_38 = (param_2 + iVar4) * 2;
      QJsonValueRef::operator=((QJsonValueRef *)&local_3c,param_5);
      ExceptionList = local_c;
      return;
    }
    uStack_2c = param_1;
    uStack_24 = param_1;
    iStack_28 = (param_2 + iVar3) * 2;
    iStack_20 = (param_2 + iVar4) * 2;
    QJsonValueRef::operator=((QJsonValueRef *)&uStack_24,(QJsonValueRef *)&uStack_2c);
    iVar4 = iVar3;
  } while( true );
}



void __cdecl
FUN_10008790(QJsonArray *param_1,QJsonArray *param_2,int param_3,QJsonArray *param_4,int param_5,
            undefined4 param_6)

{
  QJsonArray *pQVar1;
  QJsonArray *pQVar2;
  int iVar3;
  int local_10;
  QJsonArray *local_c;
  QJsonArray *local_8;
  QJsonArray *local_4;
  
  iVar3 = (int)param_4 - (int)param_2;
  do {
    if (iVar3 < 0x21) {
LAB_10008860:
      if (1 < iVar3) {
        FUN_10007e50((int)param_1,(int)param_2,param_3,(int)param_4);
      }
      return;
    }
    if (param_5 < 1) {
      if (0x20 < iVar3) {
        if (1 < (int)param_4 - (int)param_2) {
          FUN_100080f0((int)param_1,(int)param_2,param_3,(int)param_4);
        }
        FUN_100088d0((int)param_1,(int)param_2,param_3,(int)param_4);
        return;
      }
      goto LAB_10008860;
    }
    FUN_10008910(&local_10,param_1,param_2,param_3,param_4);
    pQVar2 = local_4;
    pQVar1 = local_c;
    param_5 = param_5 / 2 + (param_5 / 2) / 2;
    if ((int)local_c - (int)param_2 < (int)param_4 - (int)local_4) {
      FUN_10008790(param_1,param_2,local_10,local_c,param_5,param_6);
      param_1 = local_8;
      param_2 = pQVar2;
    }
    else {
      FUN_10008790(local_8,local_4,param_3,param_4,param_5,param_6);
      param_3 = local_10;
      param_4 = pQVar1;
    }
    iVar3 = (int)param_4 - (int)param_2;
  } while( true );
}



void __cdecl FUN_100088d0(int param_1,int param_2,int param_3,int param_4)

{
  int iVar1;
  
  iVar1 = param_4 - param_2;
  while (1 < iVar1) {
    FUN_10008570(param_1,param_2,param_3,param_4);
    param_4 = param_4 + -1;
    iVar1 = param_4 - param_2;
  }
  return;
}



void __cdecl
FUN_10008910(undefined4 *param_1,QJsonArray *param_2,QJsonArray *param_3,undefined4 param_4,
            QJsonArray *param_5)

{
  bool bVar1;
  undefined1 *unaff_EBX;
  QJsonArray *pQVar2;
  QJsonArray *pQVar3;
  QJsonArray *unaff_ESI;
  undefined1 *puVar4;
  QJsonArray *local_114;
  undefined4 uStack_110;
  QJsonArray *local_10c;
  QJsonArray *local_108;
  QJsonArray *local_104;
  QJsonArray *pQStack_100;
  QJsonArray *pQStack_fc;
  QJsonArray *pQStack_f8;
  QJsonArray *pQStack_f4;
  QJsonArray *pQStack_ec;
  QJsonArray *local_e8;
  undefined4 uStack_e4;
  QJsonArray *pQStack_e0;
  int iStack_dc;
  int aiStack_d8 [2];
  QJsonValue aQStack_d0 [8];
  QJsonValue aQStack_c8 [12];
  QJsonArray *pQStack_bc;
  QJsonArray *apQStack_b8 [2];
  QJsonValue aQStack_b0 [8];
  QJsonArray *pQStack_a8;
  QJsonArray *pQStack_a4;
  undefined4 uStack_a0;
  QJsonArray *pQStack_98;
  QJsonArray *pQStack_94;
  QJsonValue aQStack_80 [16];
  QJsonValue aQStack_70 [16];
  QJsonValue aQStack_60 [8];
  QJsonValue aQStack_58 [16];
  QJsonValue aQStack_48 [4];
  undefined1 auStack_44 [12];
  QJsonValue aQStack_38 [28];
  undefined4 uStack_1c;
  undefined4 uStack_18;
  void *local_14;
  undefined1 *puStack_10;
  undefined4 uStack_c;
  
  uStack_c = 0xffffffff;
  puStack_10 = &LAB_10012268;
  local_14 = ExceptionList;
  ExceptionList = &local_14;
  pQVar2 = (QJsonArray *)0x0;
  local_10c = param_3 + ((int)param_5 - (int)param_3) / 2;
  FUN_10008430(param_2,(int)param_3,(int)param_2,(int)local_10c,param_4,(int)(param_5 + -1));
  local_108 = local_10c + 1;
  local_104 = local_10c;
  do {
    local_104 = local_104 + -1;
    if ((int)param_3 < (int)local_10c) {
      QJsonValueRef::QJsonValueRef((QJsonValueRef *)&local_e8,param_2,(int)local_10c);
      QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_e8);
      unaff_EBX = (undefined1 *)((uint)pQVar2 | 1);
      puStack_10 = (undefined1 *)0x0;
      QJsonValueRef::QJsonValueRef((QJsonValueRef *)&uStack_e4,param_2,(int)local_108);
      QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&uStack_e4);
      local_14 = (void *)0x1;
      unaff_ESI = (QJsonArray *)((uint)pQVar2 | 3);
      bVar1 = FUN_10009650((QJsonValue *)&pQStack_e0);
      pQVar2 = unaff_ESI;
      if (bVar1) goto LAB_10008a88;
      QJsonValueRef::QJsonValueRef((QJsonValueRef *)&pQStack_100,param_2,(int)local_10c);
      QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_100);
      uStack_18 = 2;
      QJsonValueRef::QJsonValueRef((QJsonValueRef *)&pQStack_fc,param_2,(int)unaff_EBX);
      QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_fc);
      uStack_1c = 3;
      pQVar2 = (QJsonArray *)0xf;
      bVar1 = FUN_10009650(aQStack_c8);
      if (bVar1) goto LAB_10008a88;
    }
    else {
LAB_10008a88:
      uStack_110 = (QJsonArray *)((uint)uStack_110 & 0xffffff);
    }
    uStack_c = 2;
    if (((uint)pQVar2 & 8) != 0) {
      pQVar2 = (QJsonArray *)((uint)pQVar2 & 0xfffffff7);
      QJsonValue::~QJsonValue((QJsonValue *)apQStack_b8);
    }
    uStack_c = 1;
    if (((uint)pQVar2 & 4) != 0) {
      pQVar2 = (QJsonArray *)((uint)pQVar2 & 0xfffffffb);
      QJsonValue::~QJsonValue((QJsonValue *)&pQStack_a8);
    }
    uStack_c = 0;
    if (((uint)pQVar2 & 2) != 0) {
      pQVar2 = (QJsonArray *)((uint)pQVar2 & 0xfffffffd);
      QJsonValue::~QJsonValue((QJsonValue *)aiStack_d8);
    }
    uStack_c = 0xffffffff;
    if (((uint)pQVar2 & 1) != 0) {
      pQVar2 = (QJsonArray *)((uint)pQVar2 & 0xfffffffe);
      QJsonValue::~QJsonValue(aQStack_c8);
    }
    if (uStack_110._3_1_ == '\0') break;
    local_10c = local_10c + -1;
  } while( true );
LAB_10008b20:
  pQVar3 = pQVar2;
  if ((int)local_108 < (int)param_5) {
    QJsonValueRef::QJsonValueRef((QJsonValueRef *)&local_e8,param_2,(int)local_10c);
    QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_e8);
    unaff_EBX = (undefined1 *)((uint)pQVar2 | 0x10);
    puStack_10 = (undefined1 *)0x4;
    QJsonValueRef::QJsonValueRef((QJsonValueRef *)&uStack_e4,param_2,(int)local_10c);
    QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&uStack_e4);
    local_14 = (void *)0x5;
    unaff_ESI = (QJsonArray *)((uint)pQVar2 | 0x30);
    bVar1 = FUN_10009650(aQStack_b0);
    pQVar3 = unaff_ESI;
    if (bVar1) goto LAB_10008c21;
    QJsonValueRef::QJsonValueRef((QJsonValueRef *)&pQStack_100,param_2,(int)uStack_110);
    QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_100);
    uStack_18 = 6;
    QJsonValueRef::QJsonValueRef((QJsonValueRef *)&pQStack_fc,param_2,(int)unaff_EBX);
    QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_fc);
    uStack_1c = 7;
    pQVar3 = (QJsonArray *)((uint)pQVar2 | 0xf0);
    bVar1 = FUN_10009650((QJsonValue *)aiStack_d8);
    pQVar2 = pQVar3;
    if (bVar1) goto LAB_10008c21;
  }
  else {
LAB_10008c21:
    uStack_110 = (QJsonArray *)((uint)uStack_110 & 0xffffff);
    pQVar2 = pQVar3;
  }
  uStack_c = 6;
  if ((char)pQVar2 < '\0') {
    pQVar2 = (QJsonArray *)((uint)pQVar2 & 0xffffff7f);
    QJsonValue::~QJsonValue(aQStack_c8);
  }
  uStack_c = 5;
  if (((uint)pQVar2 & 0x40) != 0) {
    pQVar2 = (QJsonArray *)((uint)pQVar2 & 0xffffffbf);
    QJsonValue::~QJsonValue((QJsonValue *)apQStack_b8);
  }
  uStack_c = 4;
  if (((uint)pQVar2 & 0x20) != 0) {
    pQVar2 = (QJsonArray *)((uint)pQVar2 & 0xffffffdf);
    QJsonValue::~QJsonValue((QJsonValue *)&pQStack_a8);
  }
  uStack_c = 0xffffffff;
  if (((uint)pQVar2 & 0x10) != 0) {
    pQVar2 = (QJsonArray *)((uint)pQVar2 & 0xffffffef);
    QJsonValue::~QJsonValue((QJsonValue *)aiStack_d8);
  }
  if (uStack_110._3_1_ == '\0') {
    local_114 = local_108;
    pQStack_100 = local_10c;
    do {
      if ((int)local_114 < (int)param_5) {
        local_104 = (QJsonArray *)((int)local_10c * 2);
        puVar4 = unaff_EBX;
        do {
          pQVar2 = local_104;
          pQStack_fc = (QJsonArray *)((int)local_114 * 2);
          pQStack_a8 = param_2;
          pQStack_a4 = pQStack_fc;
          QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_a8);
          puStack_10 = (undefined1 *)0x8;
          pQStack_bc = param_2;
          apQStack_b8[0] = pQVar2;
          QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_bc);
          local_14._0_1_ = 9;
          bVar1 = FUN_10009650(aQStack_d0);
          local_14 = (void *)CONCAT31(local_14._1_3_,8);
          QJsonValue::~QJsonValue(aQStack_d0);
          local_14 = (void *)0xffffffff;
          QJsonValue::~QJsonValue(aQStack_60);
          unaff_EBX = puVar4;
          if (!bVar1) {
            pQStack_f4 = local_10c;
            pQStack_f8 = param_2;
            QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_f8);
            pQStack_100 = local_108;
            uStack_18 = 10;
            local_104 = param_2;
            QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_104);
            uStack_1c._0_1_ = 0xb;
            bVar1 = FUN_10009650(aQStack_48);
            uStack_1c = CONCAT31(uStack_1c._1_3_,10);
            QJsonValue::~QJsonValue(aQStack_48);
            uStack_1c = 0xffffffff;
            QJsonValue::~QJsonValue((QJsonValue *)&pQStack_98);
            if (bVar1) break;
            unaff_EBX = puVar4 + 1;
            local_e8 = param_2;
            if (puVar4 != auStack_44) {
              FUN_10009150(param_2,(int)puVar4,param_2,(int)auStack_44);
            }
          }
          local_114 = local_114 + 1;
          puVar4 = unaff_EBX;
        } while ((int)local_114 < (int)param_5);
      }
      pQVar2 = pQStack_100;
      if ((int)param_3 < (int)pQStack_100) {
        local_104 = pQStack_100 + -1;
        pQVar3 = local_10c;
        do {
          iStack_dc = (int)pQVar3 * 2;
          pQStack_e0 = param_2;
          aiStack_d8[0] = iStack_dc;
          QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_e0);
          pQStack_100 = (QJsonArray *)((int)local_108 * 2);
          puStack_10 = (undefined1 *)0xc;
          pQStack_ec = param_2;
          local_e8 = pQStack_100;
          QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_ec);
          local_14._0_1_ = 0xd;
          bVar1 = FUN_10009650(aQStack_80);
          local_14 = (void *)CONCAT31(local_14._1_3_,0xc);
          QJsonValue::~QJsonValue(aQStack_80);
          local_14 = (void *)0xffffffff;
          QJsonValue::~QJsonValue(aQStack_70);
          pQVar3 = local_114;
          if (!bVar1) {
            pQStack_94 = local_104;
            pQStack_98 = param_2;
            QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_98);
            uStack_a0 = uStack_e4;
            uStack_18 = 0xe;
            pQStack_a4 = param_2;
            QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&pQStack_a4);
            uStack_1c._0_1_ = 0xf;
            bVar1 = FUN_10009650(aQStack_58);
            uStack_1c = CONCAT31(uStack_1c._1_3_,0xe);
            QJsonValue::~QJsonValue(aQStack_58);
            uStack_1c = 0xffffffff;
            QJsonValue::~QJsonValue(aQStack_38);
            pQVar2 = uStack_110;
            if (bVar1) break;
            unaff_ESI = unaff_ESI + -1;
            pQVar3 = unaff_ESI;
            if (unaff_ESI != local_114) {
              FUN_10009150(param_2,(int)unaff_ESI,param_2,(int)local_114);
            }
          }
          local_104 = local_114 + -1;
          pQVar2 = pQStack_100 + -1;
          pQStack_100 = pQVar2;
        } while ((int)param_3 < (int)pQVar2);
      }
      if (pQVar2 == param_3) {
        if (local_114 == param_5) {
          param_1[1] = local_10c;
          *param_1 = param_2;
          param_1[2] = param_2;
          param_1[3] = local_108;
          ExceptionList = local_14;
          return;
        }
        if (local_108 != local_114) {
          FUN_10009150(param_2,(int)local_10c,param_2,(int)local_108);
        }
        local_108 = local_108 + 1;
        FUN_10009150(param_2,(int)local_10c,param_2,(int)local_114);
        local_114 = local_114 + 1;
        local_10c = local_10c + 1;
      }
      else {
        pQStack_100 = pQVar2 + -1;
        if (local_114 == param_5) {
          local_10c = local_10c + -1;
          if (pQStack_100 != local_10c) {
            FUN_10009150(param_2,(int)pQStack_100,param_2,(int)local_10c);
          }
          local_108 = local_108 + -1;
          FUN_10009150(param_2,(int)local_10c,param_2,(int)local_108);
        }
        else {
          FUN_10009150(param_2,(int)local_114,param_2,(int)pQStack_100);
          local_114 = local_114 + 1;
        }
      }
    } while( true );
  }
  local_108 = local_108 + 1;
  goto LAB_10008b20;
}



QObject * __cdecl
FUN_100090d0(QObject *param_1,void **param_2,undefined4 param_3,void **param_4,undefined4 param_5,
            int *param_6)

{
  undefined4 *puVar1;
  
  puVar1 = (undefined4 *)operator_new(0xc);
  if (puVar1 == (undefined4 *)0x0) {
    puVar1 = (undefined4 *)0x0;
  }
  else {
    *puVar1 = 1;
    puVar1[1] = &LAB_1000b0a0;
    puVar1[2] = param_5;
  }
  QObject::connectImpl
            (param_1,param_2,(QObject *)&param_3,param_4,(QSlotObjectBase *)&param_5,
             (ConnectionType)puVar1,param_6,(QMetaObject *)0x0);
  return param_1;
}



QVariant * __cdecl FUN_10009130(QVariant *param_1,void *param_2)

{
  FUN_10009250(param_1,param_2);
  return param_1;
}



void __cdecl FUN_10009150(undefined4 param_1,int param_2,undefined4 param_3,int param_4)

{
  QJsonValue *pQVar1;
  undefined4 local_5c;
  int local_58;
  undefined4 local_54;
  int local_50 [3];
  QJsonValue aQStack_44 [16];
  QJsonValue aQStack_34 [4];
  QJsonValue aQStack_30 [12];
  QJsonValue aQStack_24 [16];
  void *pvStack_14;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &this_100122b4;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_54 = param_3;
  local_50[0] = param_4 * 2;
  local_5c = param_1;
  local_58 = param_2 * 2;
  QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_5c);
  puStack_8 = (undefined1 *)0x0;
  QJsonValue::QJsonValue(aQStack_30,(QJsonValue *)local_50);
  puStack_8 = (undefined1 *)CONCAT31(puStack_8._1_3_,2);
  QJsonValue::~QJsonValue((QJsonValue *)local_50);
  QJsonValueRef::operator_class_QJsonValue((QJsonValueRef *)&local_58);
  local_c._0_1_ = 3;
  pQVar1 = (QJsonValue *)QJsonValue::QJsonValue(aQStack_24,aQStack_44);
  local_c._0_1_ = 4;
  QJsonValueRef::operator=((QJsonValueRef *)&stack0xffffff9c,pQVar1);
  local_c._0_1_ = 3;
  QJsonValue::~QJsonValue(aQStack_24);
  local_c = (void *)CONCAT31(local_c._1_3_,2);
  QJsonValue::~QJsonValue(aQStack_44);
  QJsonValueRef::operator=((QJsonValueRef *)&local_5c,aQStack_34);
  local_c = (void *)0xffffffff;
  QJsonValue::~QJsonValue(aQStack_34);
  ExceptionList = pvStack_14;
  return;
}



QVariant * __cdecl FUN_10009250(QVariant *param_1,void *param_2)

{
  QVariant::QVariant(param_1,8,param_2,0);
  return param_1;
}



void * __thiscall FUN_10009280(void *this,int param_1)

{
  QArrayData *pQVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  
  if (param_1 < 1) {
    *(code **)this = shared_null_exref;
  }
  else {
    pQVar1 = QArrayData::allocate(0x84,4,param_1,0);
    *(QArrayData **)this = pQVar1;
    if (pQVar1 == (QArrayData *)0x0) {
      qBadAlloc();
    }
                    // WARNING: Load size is inaccurate
    *(int *)(*this + 4) = param_1;
                    // WARNING: Load size is inaccurate
    iVar4 = *this;
    iVar2 = *(int *)(iVar4 + 0xc) + iVar4;
    iVar4 = *(int *)(iVar4 + 4) * 0x84 + *(int *)(iVar4 + 0xc) + iVar4;
    if (iVar2 != iVar4) {
      do {
        iVar3 = iVar2 + 0x84;
        if (iVar2 != 0) {
          *(undefined4 *)(iVar2 + 0x80) = 1;
        }
        iVar2 = iVar3;
      } while (iVar3 != iVar4);
      return this;
    }
  }
  return this;
}



void * __thiscall FUN_10009300(void *this,undefined4 param_1,QTimer *param_2)

{
  QTimer *pQVar1;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100122fb;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  QObject::QObject((QObject *)this,(QObject *)param_2);
  uStack_4 = 0;
  *(undefined ***)this = BlackMesaUIEngineClient::vftable;
  *(undefined4 *)((int)this + 8) = param_1;
  QMutex::QMutex((QMutex *)((int)this + 0xc),0);
  *(code **)((int)this + 0x10) = shared_null_exref;
  uStack_4._0_1_ = 2;
  *(undefined4 *)((int)this + 0x14) = 0;
  pQVar1 = (QTimer *)operator_new(0x18);
  uStack_4._0_1_ = 3;
  param_2 = pQVar1;
  if (pQVar1 == (QTimer *)0x0) {
    pQVar1 = (QTimer *)0x0;
  }
  else {
    QTimer::QTimer(pQVar1,(QObject *)0x0);
    *(undefined ***)pQVar1 = QTimer::vftable;
  }
  *(QTimer **)((int)this + 0x14) = pQVar1;
  *(uint *)(pQVar1 + 0x14) = *(uint *)(pQVar1 + 0x14) & 0xfffffffe;
  uStack_4 = CONCAT31(uStack_4._1_3_,2);
  QTimer::setInterval(*(QTimer **)((int)this + 0x14),100);
  FUN_100090d0((QObject *)&param_2,*(void ***)((int)this + 0x14),timeout_exref,(void **)this,
               FUN_1000e5e0,(int *)0x0);
  QMetaObject::Connection::~Connection((Connection *)&param_2);
  QTimer::start(*(QTimer **)((int)this + 0x14));
  ExceptionList = local_c;
  return this;
}



void __fastcall FUN_10009400(undefined4 *param_1)

{
  int iVar1;
  int *piVar2;
  Data *pDVar3;
  Data *this;
  
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) {
      return;
    }
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  pDVar3 = (Data *)*param_1;
  iVar1 = *(int *)(pDVar3 + 8);
  this = pDVar3 + (*(int *)(pDVar3 + 0xc) + 4) * 4;
  while (pDVar3 + (iVar1 + 4) * 4 != this) {
    this = this + -4;
    QString::~QString((QString *)this);
  }
  QListData::dispose(pDVar3);
  return;
}



void __fastcall FUN_10009460(undefined4 *param_1)

{
  int iVar1;
  int *piVar2;
  
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) {
      return;
    }
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  FUN_10009a40((Data *)*param_1);
  return;
}



void __fastcall FUN_10009490(undefined4 *param_1)

{
  int iVar1;
  int *piVar2;
  
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) {
      return;
    }
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  QArrayData::deallocate((QArrayData *)*param_1,0x8c,4);
  return;
}



void __fastcall FUN_100094c0(undefined4 *param_1)

{
  int iVar1;
  int *piVar2;
  
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) {
      return;
    }
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  QArrayData::deallocate((QArrayData *)*param_1,0x84,4);
  return;
}



void __fastcall FUN_100094f0(undefined4 *param_1)

{
  int iVar1;
  int *piVar2;
  
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) {
      return;
    }
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  QArrayData::deallocate((QArrayData *)*param_1,0x20c,4);
  return;
}



void __fastcall FUN_10009520(undefined4 *param_1)

{
  int iVar1;
  int *piVar2;
  
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) {
      return;
    }
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  QArrayData::deallocate((QArrayData *)*param_1,0x10,4);
  return;
}



void __fastcall FUN_10009550(QObject *param_1)

{
  int iVar1;
  int *piVar2;
  uint uVar3;
  QMessageLogger *this;
  QDebug *this_00;
  QMessageLogger local_20 [16];
  void *pvStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  puStack_8 = &LAB_10012349;
  local_c = ExceptionList;
  uVar3 = DAT_10022088 ^ (uint)&stack0xffffffd4;
  ExceptionList = &local_c;
  *(undefined ***)param_1 = BlackMesaUIEngineClient::vftable;
  local_4 = 2;
  if (*(int **)(param_1 + 0x14) != (int *)0x0) {
    (**(code **)(**(int **)(param_1 + 0x14) + 0xc))(1,uVar3);
  }
  *(undefined4 *)(param_1 + 0x14) = 0;
  this = (QMessageLogger *)QMessageLogger::QMessageLogger(local_20,(char *)0x0,0,(char *)0x0);
  this_00 = (QDebug *)QMessageLogger::debug(this);
  puStack_8._0_1_ = 3;
  QDebug::operator<<(this_00,"Singleton Types Are Deleted With QML Engine");
  puStack_8._0_1_ = 2;
  QDebug::~QDebug((QDebug *)&stack0xffffffd4);
  piVar2 = *(int **)(param_1 + 0x10);
  puStack_8._0_1_ = 1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) goto LAB_10009606;
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) goto LAB_10009606;
  }
  FUN_10009a40(*(Data **)(param_1 + 0x10));
LAB_10009606:
  puStack_8 = (undefined1 *)((uint)puStack_8._1_3_ << 8);
  QMutex::~QMutex((QMutex *)(param_1 + 0xc));
  puStack_8 = (undefined1 *)0xffffffff;
  QObject::~QObject(param_1);
  ExceptionList = pvStack_10;
  return;
}



void __fastcall FUN_10009640(undefined4 *param_1)

{
  int iVar1;
  int *piVar2;
  Data *pDVar3;
  Data *this;
  
  piVar2 = (int *)*param_1;
  if (*piVar2 != 0) {
    if (*piVar2 == -1) {
      return;
    }
    LOCK();
    iVar1 = *piVar2;
    *piVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  pDVar3 = (Data *)*param_1;
  iVar1 = *(int *)(pDVar3 + 8);
  this = pDVar3 + (*(int *)(pDVar3 + 0xc) + 4) * 4;
  while (pDVar3 + (iVar1 + 4) * 4 != this) {
    this = this + -4;
    QString::~QString((QString *)this);
  }
  QListData::dispose(pDVar3);
  return;
}



bool FUN_10009650(QJsonValue *param_1)

{
  bool bVar1;
  QJsonObject *this;
  QJsonValueRef *this_00;
  QJsonValue *this_01;
  uint uStack_38;
  QString aQStack_28 [16];
  void *pvStack_18;
  int iStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &this_1001238b;
  local_c = ExceptionList;
  uStack_38 = DAT_10022088 ^ (uint)&stack0xffffffcc;
  ExceptionList = &local_c;
  QString::fromAscii_helper("isOfficial",10);
  uStack_4 = 0;
  this = (QJsonObject *)QJsonValue::toObject(param_1);
  puStack_8 = (undefined1 *)CONCAT31(puStack_8._1_3_,1);
  this_00 = (QJsonValueRef *)QJsonObject::operator[](this,aQStack_28);
  this_01 = (QJsonValue *)QJsonValueRef::toValue(this_00);
  iStack_10._0_1_ = 2;
  bVar1 = QJsonValue::toBool(this_01,false);
  iStack_10._0_1_ = 1;
  QJsonValue::~QJsonValue((QJsonValue *)aQStack_28);
  iStack_10 = (uint)iStack_10._1_3_ << 8;
  QJsonObject::~QJsonObject((QJsonObject *)&uStack_38);
  iStack_10 = 0xffffffff;
  QString::~QString((QString *)&stack0xffffffc4);
  ExceptionList = pvStack_18;
  return bVar1;
}



void * __thiscall FUN_10009720(void *this,byte param_1)

{
  FUN_10009550((QObject *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



void __thiscall FUN_10009740(void *this,QString *param_1)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  void *unaff_ESI;
  void **ppvVar4;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar4 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0x114))(pcVar3,ppvVar4,uVar2);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return;
}



void __thiscall FUN_100097c0(void *this,QString *param_1)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  void *unaff_ESI;
  void **ppvVar4;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar4 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0x118))(pcVar3,ppvVar4,uVar2);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return;
}



void __thiscall FUN_10009840(void *this,QVariant *param_1)

{
  undefined4 *puVar1;
  QVariant *this_00;
  undefined4 uVar2;
  void **ppvVar3;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_100123bb;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
                    // WARNING: Load size is inaccurate
  if ((**this != 1) && (**this != 0)) {
    puVar1 = (undefined4 *)FUN_10009d00(this,0x7fffffff,1);
    local_8 = 0;
    this_00 = (QVariant *)operator_new(0x10);
    local_8 = CONCAT31(local_8._1_3_,1);
    if (this_00 != (QVariant *)0x0) {
      uVar2 = QVariant::QVariant(this_00,param_1);
      *puVar1 = uVar2;
      ExceptionList = local_10;
      return;
    }
    *puVar1 = 0;
    ExceptionList = local_10;
    return;
  }
  ppvVar3 = QListData::append((QListData *)this);
  local_8 = 4;
  FUN_1000d230(ppvVar3,param_1);
  ExceptionList = local_10;
  return;
}



void Catch_All_100098e0(void)

{
  int *piVar1;
  int unaff_EBP;
  
  piVar1 = (int *)(**(int **)(unaff_EBP + -0x14) + 0xc);
  *piVar1 = *piVar1 + -1;
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



QArrayData * __fastcall FUN_10009920(int *param_1)

{
  int iVar1;
  QArrayData *pQVar2;
  
  iVar1 = *(int *)*param_1;
  if ((iVar1 != 1) && (iVar1 != 0)) {
    if ((((int *)*param_1)[2] & 0x7fffffffU) == 0) {
      pQVar2 = QArrayData::allocate(0x8c,4,0,2);
      *param_1 = (int)pQVar2;
      return pQVar2 + *(int *)(pQVar2 + 0xc);
    }
    FUN_1000d9b0(param_1,*(int *)(*param_1 + 4),*(uint *)(*param_1 + 8) & 0x7fffffff,0);
  }
  return (QArrayData *)(*(int *)(*param_1 + 0xc) + *param_1);
}



QArrayData * __fastcall FUN_10009980(int *param_1)

{
  int iVar1;
  QArrayData *pQVar2;
  
  iVar1 = *(int *)*param_1;
  if ((iVar1 != 1) && (iVar1 != 0)) {
    if ((((int *)*param_1)[2] & 0x7fffffffU) == 0) {
      pQVar2 = QArrayData::allocate(0x84,4,0,2);
      *param_1 = (int)pQVar2;
      return pQVar2 + *(int *)(pQVar2 + 0xc);
    }
    FUN_1000db60(param_1,*(int *)(*param_1 + 4),*(uint *)(*param_1 + 8) & 0x7fffffff,0);
  }
  return (QArrayData *)(*(int *)(*param_1 + 0xc) + *param_1);
}



QArrayData * __fastcall FUN_100099e0(int *param_1)

{
  int iVar1;
  QArrayData *pQVar2;
  
  iVar1 = *(int *)*param_1;
  if ((iVar1 != 1) && (iVar1 != 0)) {
    if ((((int *)*param_1)[2] & 0x7fffffffU) == 0) {
      pQVar2 = QArrayData::allocate(0x20c,4,0,2);
      *param_1 = (int)pQVar2;
      return pQVar2 + *(int *)(pQVar2 + 0xc);
    }
    FUN_1000dd10(param_1,*(int *)(*param_1 + 4),*(uint *)(*param_1 + 8) & 0x7fffffff,0);
  }
  return (QArrayData *)(*(int *)(*param_1 + 0xc) + *param_1);
}



void FUN_10009a40(Data *param_1)

{
  int iVar1;
  QVariant *this;
  Data *pDVar2;
  
  iVar1 = *(int *)(param_1 + 8);
  pDVar2 = param_1 + (*(int *)(param_1 + 0xc) + 4) * 4;
  while (param_1 + (iVar1 + 4) * 4 != pDVar2) {
    this = *(QVariant **)(pDVar2 + -4);
    pDVar2 = pDVar2 + -4;
    if (this != (QVariant *)0x0) {
      QVariant::~QVariant(this);
      operator_delete(this);
    }
  }
  QListData::dispose(param_1);
  return;
}



void __cdecl FUN_10009aa0(QArrayData *param_1)

{
  QArrayData::deallocate(param_1,0x8c,4);
  return;
}



void __cdecl FUN_10009ac0(QArrayData *param_1)

{
  QArrayData::deallocate(param_1,0x84,4);
  return;
}



void __cdecl FUN_10009ae0(QArrayData *param_1)

{
  QArrayData::deallocate(param_1,0x20c,4);
  return;
}



void __cdecl FUN_10009b00(QArrayData *param_1)

{
  QArrayData::deallocate(param_1,0x10,4);
  return;
}



void FUN_10009b20(void *param_1,void *param_2)

{
  void *pvVar1;
  
  if (param_1 != param_2) {
    do {
      pvVar1 = (void *)((int)param_1 + 0x8c);
      if (param_1 != (void *)0x0) {
        memset(param_1,0,0x8c);
      }
      param_1 = pvVar1;
    } while (pvVar1 != param_2);
  }
  return;
}



void FUN_10009b60(int param_1,int param_2)

{
  int iVar1;
  
  if (param_1 != param_2) {
    do {
      iVar1 = param_1 + 0x84;
      if (param_1 != 0) {
        *(undefined4 *)(param_1 + 0x80) = 1;
      }
      param_1 = iVar1;
    } while (iVar1 != param_2);
  }
  return;
}



void FUN_10009b90(void *param_1,void *param_2)

{
  void *pvVar1;
  
  if (param_1 != param_2) {
    do {
      pvVar1 = (void *)((int)param_1 + 0x20c);
      if (param_1 != (void *)0x0) {
        memset(param_1,0,0x20c);
      }
      param_1 = pvVar1;
    } while (pvVar1 != param_2);
  }
  return;
}



void FUN_10009bd0(undefined4 *param_1,undefined4 *param_2)

{
  undefined4 *puVar1;
  
  if (param_1 != param_2) {
    do {
      puVar1 = param_1 + 4;
      if (param_1 != (undefined4 *)0x0) {
        *param_1 = 0;
        param_1[1] = 0;
        param_1[2] = 0;
        param_1[3] = 0;
      }
      param_1 = puVar1;
    } while (puVar1 != param_2);
  }
  return;
}



void __thiscall FUN_10009c10(void *this,int param_1)

{
  int iVar1;
  int iVar2;
  int iVar3;
  Data *pDVar4;
  Data *this_00;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_100123e0;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
                    // WARNING: Load size is inaccurate
  iVar1 = *this;
  iVar2 = *(int *)(iVar1 + 8);
  pDVar4 = QListData::detach((QListData *)this,param_1);
                    // WARNING: Load size is inaccurate
  iVar3 = *this;
  local_8 = 0;
  FUN_1000d2b0((QString *)(iVar3 + (*(int *)(iVar3 + 8) + 4) * 4),
               (QString *)(iVar3 + (*(int *)(iVar3 + 0xc) + 4) * 4),iVar1 + (iVar2 + 4) * 4);
  local_8 = 0xffffffff;
  if (*(int *)pDVar4 != 0) {
    if (*(int *)pDVar4 == -1) {
      ExceptionList = local_10;
      return;
    }
    LOCK();
    iVar1 = *(int *)pDVar4;
    *(int *)pDVar4 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      ExceptionList = local_10;
      return;
    }
  }
  iVar1 = *(int *)(pDVar4 + 8);
  this_00 = pDVar4 + (*(int *)(pDVar4 + 0xc) + 4) * 4;
  while (pDVar4 + (iVar1 + 4) * 4 != this_00) {
    this_00 = this_00 + -4;
    QString::~QString((QString *)this_00);
  }
  QListData::dispose(pDVar4);
  ExceptionList = local_10;
  return;
}



void Catch_All_10009ce1(void)

{
  undefined4 *puVar1;
  int unaff_EBP;
  
  puVar1 = *(undefined4 **)(unaff_EBP + -0x14);
  QListData::dispose((Data *)*puVar1);
  *puVar1 = *(undefined4 *)(unaff_EBP + 8);
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



int __thiscall FUN_10009d00(void *this,int param_1,int param_2)

{
  undefined4 *puVar1;
  undefined4 *puVar2;
  int iVar3;
  Data *pDVar4;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_10012400;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
                    // WARNING: Load size is inaccurate
  puVar1 = (undefined4 *)(*this + (*(int *)(*this + 8) + 4) * 4);
  pDVar4 = QListData::detach_grow((QListData *)this,&param_1,param_2);
                    // WARNING: Load size is inaccurate
  local_8 = 0;
  puVar2 = (undefined4 *)(*this + (*(int *)(*this + 8) + 4) * 4);
  FUN_1000d2f0(puVar2,puVar2 + param_1,puVar1);
                    // WARNING: Load size is inaccurate
  iVar3 = *this;
  local_8 = 2;
  FUN_1000d2f0((undefined4 *)(iVar3 + (*(int *)(iVar3 + 8) + 4 + param_1 + param_2) * 4),
               (undefined4 *)(iVar3 + (*(int *)(iVar3 + 0xc) + 4) * 4),puVar1 + param_1);
  local_8 = 0xffffffff;
  if (*(int *)pDVar4 != 0) {
    if (*(int *)pDVar4 == -1) goto LAB_10009dcd;
    LOCK();
    iVar3 = *(int *)pDVar4;
    *(int *)pDVar4 = iVar3 + -1;
    UNLOCK();
    if (iVar3 + -1 != 0) goto LAB_10009dcd;
  }
  FUN_10009a40(pDVar4);
LAB_10009dcd:
                    // WARNING: Load size is inaccurate
  ExceptionList = local_10;
  return *this + (*(int *)(*this + 8) + 4 + param_1) * 4;
}



void Catch_All_10009def(void)

{
  int *piVar1;
  int iVar2;
  int unaff_EBP;
  
  piVar1 = *(int **)(unaff_EBP + -0x14);
  iVar2 = *piVar1;
  FUN_1000d3c0(iVar2 + (*(int *)(iVar2 + 8) + 4) * 4,
               iVar2 + (*(int *)(unaff_EBP + 8) + 4 + *(int *)(iVar2 + 8)) * 4);
  QListData::dispose((Data *)*piVar1);
  *piVar1 = *(int *)(unaff_EBP + -0x18);
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void Catch_All_10009e2a(void)

{
  undefined4 *puVar1;
  int unaff_EBP;
  
  puVar1 = *(undefined4 **)(unaff_EBP + -0x14);
  QListData::dispose((Data *)*puVar1);
  *puVar1 = *(undefined4 *)(unaff_EBP + -0x18);
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



QArrayData * __fastcall FUN_10009e50(int *param_1)

{
  int iVar1;
  QArrayData *pQVar2;
  
  iVar1 = *(int *)*param_1;
  if ((iVar1 != 1) && (iVar1 != 0)) {
    if ((((int *)*param_1)[2] & 0x7fffffffU) == 0) {
      pQVar2 = QArrayData::allocate(0x8c,4,0,2);
      *param_1 = (int)pQVar2;
      return pQVar2 + *(int *)(pQVar2 + 4) * 0x8c + *(int *)(pQVar2 + 0xc);
    }
    FUN_1000d9b0(param_1,*(int *)(*param_1 + 4),*(uint *)(*param_1 + 8) & 0x7fffffff,0);
  }
  iVar1 = *param_1;
  return (QArrayData *)(*(int *)(iVar1 + 4) * 0x8c + *(int *)(iVar1 + 0xc) + iVar1);
}



QArrayData * __fastcall FUN_10009ec0(int *param_1)

{
  int iVar1;
  QArrayData *pQVar2;
  
  iVar1 = *(int *)*param_1;
  if ((iVar1 != 1) && (iVar1 != 0)) {
    if ((((int *)*param_1)[2] & 0x7fffffffU) == 0) {
      pQVar2 = QArrayData::allocate(0x84,4,0,2);
      *param_1 = (int)pQVar2;
      return pQVar2 + *(int *)(pQVar2 + 4) * 0x84 + *(int *)(pQVar2 + 0xc);
    }
    FUN_1000db60(param_1,*(int *)(*param_1 + 4),*(uint *)(*param_1 + 8) & 0x7fffffff,0);
  }
  iVar1 = *param_1;
  return (QArrayData *)(*(int *)(iVar1 + 4) * 0x84 + *(int *)(iVar1 + 0xc) + iVar1);
}



QArrayData * __fastcall FUN_10009f30(int *param_1)

{
  int iVar1;
  QArrayData *pQVar2;
  
  iVar1 = *(int *)*param_1;
  if ((iVar1 != 1) && (iVar1 != 0)) {
    if ((((int *)*param_1)[2] & 0x7fffffffU) == 0) {
      pQVar2 = QArrayData::allocate(0x20c,4,0,2);
      *param_1 = (int)pQVar2;
      return pQVar2 + *(int *)(pQVar2 + 4) * 0x20c + *(int *)(pQVar2 + 0xc);
    }
    FUN_1000dd10(param_1,*(int *)(*param_1 + 4),*(uint *)(*param_1 + 8) & 0x7fffffff,0);
  }
  iVar1 = *param_1;
  return (QArrayData *)(*(int *)(iVar1 + 4) * 0x20c + *(int *)(iVar1 + 0xc) + iVar1);
}



QArrayData * __fastcall FUN_10009fa0(int *param_1)

{
  int iVar1;
  QArrayData *pQVar2;
  
  iVar1 = *(int *)*param_1;
  if ((iVar1 != 1) && (iVar1 != 0)) {
    if ((((int *)*param_1)[2] & 0x7fffffffU) == 0) {
      pQVar2 = QArrayData::allocate(0x10,4,0,2);
      *param_1 = (int)pQVar2;
      return pQVar2 + *(int *)(pQVar2 + 4) * 0x10 + *(int *)(pQVar2 + 0xc);
    }
    FUN_1000ded0(param_1,*(int *)(*param_1 + 4),*(uint *)(*param_1 + 8) & 0x7fffffff,0);
  }
  iVar1 = *param_1;
  return (QArrayData *)(*(int *)(iVar1 + 4) * 0x10 + *(int *)(iVar1 + 0xc) + iVar1);
}



void __thiscall FUN_1000a010(void *this,QString *param_1)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  void *unaff_ESI;
  void **ppvVar4;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar4 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLocal8Bit(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 8))(pcVar3,ppvVar4,uVar2);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return;
}



void __thiscall FUN_1000a090(void *this,QString *param_1)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  void *unaff_ESI;
  void **ppvVar4;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar4 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLocal8Bit(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0xc))(pcVar3,ppvVar4,uVar2);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return;
}



void __thiscall FUN_1000a110(void *this,QString *param_1)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  void *unaff_ESI;
  void **ppvVar4;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar4 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLocal8Bit(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 4))(pcVar3,ppvVar4,uVar2);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return;
}



undefined4 * __fastcall FUN_1000a190(int param_1)

{
  QArrayData QVar1;
  code *this;
  QArrayData *pQVar2;
  QArrayData *pQVar3;
  int iVar4;
  QVariant *pQVar5;
  QVariant *pQVar6;
  QArrayData *pQVar7;
  code *pcVar8;
  undefined4 *puVar9;
  QArrayData *unaff_EBP;
  code *pcVar10;
  QArrayData *unaff_EDI;
  int iStack_74;
  QString aQStack_70 [4];
  undefined4 local_6c;
  undefined4 uStack_68;
  undefined4 uStack_64;
  QArrayData *pQStack_60;
  QVariant aQStack_5c [8];
  undefined4 local_54;
  QVariant aQStack_50 [16];
  QVariant aQStack_40 [4];
  QVariant aQStack_3c [16];
  QVariant aQStack_2c [16];
  void *pvStack_1c;
  undefined1 uStack_18;
  undefined1 uStack_14;
  undefined4 *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  puStack_8 = &LAB_1001249a;
  local_c = (undefined4 *)ExceptionList;
  ExceptionList = &local_c;
  local_54 = 0;
  local_6c = 0;
  local_4 = 0;
  (**(code **)(**(int **)(param_1 + 8) + 0x28))(&local_6c,0,DAT_10022088 ^ (uint)&stack0xffffff7c);
  FUN_10009280(&stack0xffffff84,iStack_74);
  local_c = (undefined4 *)0x1;
  if ((*(int *)unaff_EBP != 1) && (*(int *)unaff_EBP != 0)) {
    if ((*(uint *)(unaff_EBP + 8) & 0x7fffffff) == 0) {
      unaff_EBP = QArrayData::allocate(0x84,4,0,2);
    }
    else {
      FUN_1000db60(&stack0xffffff84,*(int *)(unaff_EBP + 4),*(uint *)(unaff_EBP + 8) & 0x7fffffff,0)
      ;
    }
  }
  (**(code **)(**(int **)(param_1 + 8) + 0x28))(&iStack_74,unaff_EBP + *(int *)(unaff_EBP + 0xc));
  puVar9 = local_c;
  *local_c = shared_null_exref;
  uStack_64 = 1;
  pQVar2 = FUN_10009980((int *)&stack0xffffff7c);
  pQStack_60 = FUN_10009ec0((int *)&stack0xffffff7c);
  pcVar8 = fromAscii_helper_exref;
  if (pQVar2 != pQStack_60) {
    do {
      pcVar10 = QVariant_exref;
      this = shared_null_exref;
      uStack_14 = 2;
      if (pQVar2 == (QArrayData *)0x0) {
        iVar4 = -1;
      }
      else {
        pQVar3 = pQVar2;
        do {
          QVar1 = *pQVar3;
          pQVar3 = pQVar3 + 1;
        } while (QVar1 != (QArrayData)0x0);
        iVar4 = (int)pQVar3 - (int)(pQVar2 + 1);
      }
      iStack_74 = (*pcVar8)(pQVar2,iVar4);
      uStack_14 = 3;
      QVariant::QVariant(aQStack_5c,(QString *)&iStack_74);
      uStack_14 = 4;
      (*pcVar8)(&param_1_10014fb8,4);
      pQVar6 = aQStack_5c;
      uStack_14 = 5;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xffffff80,(QString *)&stack0xffffff88);
      QVariant::operator=(pQVar5,pQVar6);
      uStack_14 = 4;
      QString::~QString((QString *)&stack0xffffff88);
      uStack_14 = 3;
      QVariant::~QVariant(aQStack_5c);
      uStack_14 = 2;
      QString::~QString((QString *)&iStack_74);
      pQVar3 = pQVar2 + 0x40;
      if (pQVar3 == (QArrayData *)0x0) {
        iVar4 = -1;
      }
      else {
        pQVar7 = pQVar3;
        do {
          QVar1 = *pQVar7;
          pQVar7 = pQVar7 + 1;
        } while (QVar1 != (QArrayData)0x0);
        iVar4 = (int)pQVar7 - (int)(pQVar2 + 0x41);
        pcVar10 = QVariant_exref;
      }
      local_6c = (*pcVar8)(pQVar3,iVar4);
      uStack_14 = 6;
      (*pcVar10)(&local_6c);
      uStack_18 = 7;
      iStack_74 = (*pcVar8)("model",5);
      pQVar6 = aQStack_50;
      uStack_18 = 8;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xffffff7c,(QString *)&iStack_74);
      QVariant::operator=(pQVar5,pQVar6);
      uStack_18 = 7;
      QString::~QString((QString *)&iStack_74);
      uStack_18 = 6;
      QVariant::~QVariant(aQStack_50);
      uStack_18 = 2;
      QString::~QString(aQStack_70);
      QVariant::QVariant(aQStack_40,*(int *)(pQVar2 + 0x80));
      uStack_18 = 9;
      uStack_68 = (*pcVar8)("skins",5);
      pQVar6 = aQStack_3c;
      uStack_14 = 10;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xffffff80,(QString *)&uStack_68);
      QVariant::operator=(pQVar5,pQVar6);
      uStack_14 = 9;
      QString::~QString((QString *)&uStack_68);
      uStack_14 = 2;
      QVariant::~QVariant(aQStack_3c);
      pQVar6 = FUN_10009130(aQStack_2c,&stack0xffffff80);
      uStack_14 = 0xb;
      FUN_10009840(local_c,pQVar6);
      uStack_14 = 2;
      QVariant::~QVariant(aQStack_2c);
      uStack_14 = 1;
      if (*(int *)this == 0) {
LAB_1000a4de:
        iVar4 = *(int *)(this + 0xc);
        if (iVar4 != 0) {
          QString::~QString((QString *)(iVar4 + 0xc));
          QVariant::~QVariant((QVariant *)(iVar4 + 0x10));
          if (*(int *)(iVar4 + 4) != 0) {
            FUN_100041f0(*(int *)(iVar4 + 4));
          }
          if (*(int *)(iVar4 + 8) != 0) {
            FUN_100041f0(*(int *)(iVar4 + 8));
          }
          QMapDataBase::freeTree((QMapDataBase *)this,*(QMapNodeBase **)(this + 0xc),8);
        }
        QMapDataBase::freeData((QMapDataBase *)this);
        pcVar8 = fromAscii_helper_exref;
      }
      else if (*(int *)this != -1) {
        LOCK();
        iVar4 = *(int *)this;
        *(int *)this = iVar4 + -1;
        UNLOCK();
        if (iVar4 + -1 == 0) goto LAB_1000a4de;
      }
      pQVar2 = pQVar2 + 0x84;
      puVar9 = local_c;
    } while (pQVar2 != pQStack_60);
  }
  if (*(int *)unaff_EDI != 0) {
    if (*(int *)unaff_EDI == -1) {
      ExceptionList = pvStack_1c;
      return puVar9;
    }
    LOCK();
    iVar4 = *(int *)unaff_EDI;
    *(int *)unaff_EDI = *(int *)unaff_EDI + -1;
    UNLOCK();
    if (iVar4 != 1) {
      ExceptionList = pvStack_1c;
      return puVar9;
    }
  }
  QArrayData::deallocate(unaff_EDI,0x84,4);
  ExceptionList = pvStack_1c;
  return puVar9;
}



// WARNING: Function: __alloca_probe replaced with injection: alloca_probe

void __thiscall FUN_1000a590(void *this,undefined4 param_1)

{
  QString *this_00;
  undefined4 uStack_4028;
  uint uStack_4024;
  undefined1 auStack_401c [4];
  undefined4 local_4018;
  undefined4 local_4014;
  undefined1 local_4010 [16372];
  uint uStack_1c;
  void *pvStack_18;
  uint local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100126af;
  local_c = ExceptionList;
  local_10 = DAT_10022088 ^ (uint)auStack_401c;
  uStack_4024 = DAT_10022088 ^ (uint)&stack0xffffbfe0;
  ExceptionList = &local_c;
  local_4018 = 0;
  uStack_4028 = 0x4000;
  local_4014 = param_1;
  (**(code **)(**(int **)((int)this + 8) + 0x40))(local_4010);
  this_00 = (QString *)QString::fromLatin1((char *)&uStack_4024,(int)&local_4018);
  local_c = (void *)0x1;
  QString::trimmed(this_00);
  uStack_4024 = 1;
  local_10 = local_10 & 0xffffff00;
  QString::~QString((QString *)&uStack_4028);
  ExceptionList = pvStack_18;
  FUN_10010b2e(uStack_1c ^ (uint)&uStack_4028);
  return;
}



void __fastcall FUN_1000a660(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000a665. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x74))();
  return;
}



undefined1 __thiscall FUN_1000a670(void *this,QString *param_1)

{
  int iVar1;
  undefined1 uVar2;
  uint uVar3;
  QByteArray *this_00;
  char *pcVar4;
  void *unaff_EBX;
  void **ppvVar5;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100124c9;
  local_c = ExceptionList;
  uVar3 = DAT_10022088 ^ (uint)&stack0xffffffe4;
  ExceptionList = &local_c;
  ppvVar5 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar4 = QByteArray::constData(this_00);
  uVar2 = (**(code **)(iVar1 + 0xcc))(pcVar4,ppvVar5,uVar3);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_EBX;
  return uVar2;
}



float10 __thiscall FUN_1000a700(void *param_1,QString *param_2)

{
  int iVar1;
  uint uVar2;
  QByteArray *this;
  char *pcVar3;
  void *unaff_ESI;
  float10 fVar4;
  void **ppvVar5;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  float fStack_4;
  
  fStack_4 = -NAN;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar5 = &local_10;
  local_10 = param_1;
  this = (QByteArray *)QString::toLatin1(param_2);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)param_1 + 8);
  pcVar3 = QByteArray::constData(this);
  fVar4 = (float10)(**(code **)(iVar1 + 0xc4))(pcVar3,ppvVar5,uVar2);
  local_c = (void *)0xffffffff;
  fStack_4 = (float)fVar4;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return (float10)fStack_4;
}



undefined4 __thiscall FUN_1000a790(void *this,QString *param_1)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  undefined4 uVar4;
  void *unaff_ESI;
  void **ppvVar5;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar5 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  uVar4 = (**(code **)(iVar1 + 200))(pcVar3,ppvVar5,uVar2);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return uVar4;
}



char * __thiscall FUN_1000a810(void *this,undefined4 param_1,QString *param_2)

{
  uint uVar1;
  QByteArray *this_00;
  char *pcVar2;
  int iVar3;
  void **ppvVar4;
  void *local_14;
  undefined4 local_10;
  void *local_c;
  undefined1 *puStack_8;
  char *pcStack_4;
  
  pcStack_4 = (char *)0xffffffff;
  puStack_8 = &LAB_100124f9;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffe4;
  ExceptionList = &local_c;
  ppvVar4 = &local_14;
  local_10 = 0;
  this_00 = (QByteArray *)QString::toLatin1(param_2);
  puStack_8 = (undefined1 *)0x0;
  iVar3 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  iVar3 = (**(code **)(iVar3 + 0xd4))(pcVar2,ppvVar4,uVar1);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe4);
  pcVar2 = pcStack_4;
  QString::fromLatin1(pcStack_4,iVar3);
  ExceptionList = local_14;
  return pcVar2;
}



void __thiscall FUN_1000a8b0(void *this,undefined4 param_1,QString *param_2)

{
  int iVar1;
  QByteArray *this_00;
  char *pcVar2;
  undefined4 unaff_ESI;
  undefined4 unaff_EDI;
  undefined4 *puVar3;
  uint uStack_28;
  undefined4 local_1c;
  void *pvStack_18;
  undefined4 uStack_10;
  void *local_c;
  undefined4 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = (undefined4 *)&LAB_10012e89;
  local_c = ExceptionList;
  uStack_28 = DAT_10022088 ^ (uint)&stack0xffffffdc;
  ExceptionList = &local_c;
  puVar3 = &local_1c;
  this_00 = (QByteArray *)QString::toLatin1(param_2);
  puStack_8 = (undefined4 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0xd0))(&local_1c,pcVar2,puVar3);
  uStack_10 = 0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&uStack_28);
  *puStack_8 = unaff_EDI;
  puStack_8[1] = unaff_ESI;
  puStack_8[2] = local_1c;
  ExceptionList = pvStack_18;
  return;
}



void __thiscall FUN_1000a960(void *this,undefined4 *param_1)

{
  QVariant *pQVar1;
  QVariant *pQVar2;
  QVariant aQStack_b0 [16];
  undefined4 uStack_a0;
  undefined4 local_9c;
  undefined4 *local_98;
  undefined1 local_94 [60];
  char acStack_58 [64];
  int iStack_18;
  uint local_14;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  puStack_8 = &this_1001258a;
  local_c = ExceptionList;
  local_10 = (void *)(DAT_10022088 ^ (uint)aQStack_b0);
  ExceptionList = &local_c;
  local_9c = 0;
  local_14 = 1;
  local_4 = 0;
  local_98 = param_1;
  (**(code **)(**(int **)((int)this + 8) + 0x2c))(local_94,DAT_10022088 ^ (uint)&stack0xffffff44);
  *param_1 = shared_null_exref;
  puStack_8 = (undefined1 *)0x0;
  uStack_a0 = 1;
  QVariant::QVariant(aQStack_b0,(char *)&local_98);
  puStack_8 = (undefined1 *)0x1;
  QString::fromAscii_helper((char *)&param_1_10014fb8,4);
  pQVar2 = aQStack_b0;
  puStack_8._0_1_ = 2;
  pQVar1 = (QVariant *)FUN_10003770(param_1,(QString *)&stack0xffffff4c);
  QVariant::operator=(pQVar1,pQVar2);
  puStack_8._0_1_ = 1;
  QString::~QString((QString *)&stack0xffffff4c);
  puStack_8 = (undefined1 *)((uint)puStack_8._1_3_ << 8);
  QVariant::~QVariant(aQStack_b0);
  QVariant::QVariant(aQStack_b0,acStack_58);
  puStack_8 = (undefined1 *)0x3;
  QString::fromAscii_helper("model",5);
  pQVar2 = aQStack_b0;
  puStack_8._0_1_ = 4;
  pQVar1 = (QVariant *)FUN_10003770(param_1,(QString *)&stack0xffffff4c);
  QVariant::operator=(pQVar1,pQVar2);
  puStack_8._0_1_ = 3;
  QString::~QString((QString *)&stack0xffffff4c);
  puStack_8 = (undefined1 *)((uint)puStack_8._1_3_ << 8);
  QVariant::~QVariant(aQStack_b0);
  QVariant::QVariant(aQStack_b0,iStack_18);
  puStack_8 = (undefined1 *)0x5;
  QString::fromAscii_helper("skins",5);
  pQVar2 = aQStack_b0;
  puStack_8._0_1_ = 6;
  pQVar1 = (QVariant *)FUN_10003770(param_1,(QString *)&stack0xffffff4c);
  QVariant::operator=(pQVar1,pQVar2);
  puStack_8._0_1_ = 5;
  QString::~QString((QString *)&stack0xffffff4c);
  puStack_8 = (undefined1 *)((uint)puStack_8._1_3_ << 8);
  QVariant::~QVariant(aQStack_b0);
  ExceptionList = local_10;
  FUN_10010b2e(local_14 ^ (uint)&stack0xffffff4c);
  return;
}



undefined4 __thiscall FUN_1000ab70(void *this,QString *param_1)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  undefined4 uVar4;
  void *unaff_ESI;
  void **ppvVar5;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar5 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  uVar4 = (**(code **)(iVar1 + 0x30))(pcVar3,ppvVar5,uVar2);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return uVar4;
}



void __fastcall FUN_1000abf0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000abf5. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x6c))();
  return;
}



undefined4 __fastcall FUN_1000ac00(int param_1)

{
  int iVar1;
  QString *this;
  undefined4 unaff_retaddr;
  undefined4 local_14;
  void *pvStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100125e3;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_14 = 0;
  iVar1 = (**(code **)(**(int **)(param_1 + 8) + 0x3c))(0xffffffff,DAT_10022088 ^ (uint)&local_14);
  this = (QString *)QString::fromLatin1((char *)&pvStack_10,iVar1);
  uStack_4 = 1;
  QString::trimmed(this);
  puStack_8 = (undefined1 *)((uint)puStack_8 & 0xffffff00);
  QString::~QString((QString *)&local_14);
  ExceptionList = pvStack_10;
  return unaff_retaddr;
}



undefined4 __fastcall FUN_1000ac90(int param_1)

{
  int iVar1;
  QString *this;
  undefined4 unaff_retaddr;
  undefined4 local_14;
  void *pvStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100125e3;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_14 = 0;
  iVar1 = (**(code **)(**(int **)(param_1 + 8) + 0x48))(0xffffffff,DAT_10022088 ^ (uint)&local_14);
  this = (QString *)QString::fromLatin1((char *)&pvStack_10,iVar1);
  uStack_4 = 1;
  QString::trimmed(this);
  puStack_8 = (undefined1 *)((uint)puStack_8 & 0xffffff00);
  QString::~QString((QString *)&local_14);
  ExceptionList = pvStack_10;
  return unaff_retaddr;
}



undefined4 __fastcall FUN_1000ad20(int param_1)

{
  int iVar1;
  QString *this;
  undefined4 unaff_retaddr;
  undefined4 local_14;
  void *pvStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100125e3;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_14 = 0;
  iVar1 = (**(code **)(**(int **)(param_1 + 8) + 0x4c))(0xffffffff,DAT_10022088 ^ (uint)&local_14);
  this = (QString *)QString::fromLatin1((char *)&pvStack_10,iVar1);
  uStack_4 = 1;
  QString::trimmed(this);
  puStack_8 = (undefined1 *)((uint)puStack_8 & 0xffffff00);
  QString::~QString((QString *)&local_14);
  ExceptionList = pvStack_10;
  return unaff_retaddr;
}



void __fastcall FUN_1000adb0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000adb5. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x50))();
  return;
}



QString * __thiscall FUN_1000adc0(void *this,QString *param_1,QString *param_2)

{
  bool bVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  int iVar4;
  QString *pQVar5;
  undefined4 uVar6;
  QByteArray *pQVar7;
  QTypedArrayData<> *pQStack_1c;
  QString aQStack_18 [4];
  QString aQStack_14 [4];
  QByteArray aQStack_10 [4];
  void *local_c;
  undefined1 *puStack_8;
  uint uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012657;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffd4;
  ExceptionList = &local_c;
  pQStack_1c = QString::fromAscii_helper((char *)&param_1_1001529c,1);
  uStack_4 = 1;
  bVar1 = QString::startsWith(param_2,(QString *)&pQStack_1c,1);
  bVar1 = !bVar1;
  if (bVar1) {
    pQVar5 = (QString *)QString::QString(aQStack_18,param_2);
  }
  else {
    pQVar7 = aQStack_10;
    this_00 = (QByteArray *)QString::toLatin1(param_2);
    uVar6 = 0xffffffff;
    puStack_8 = (undefined1 *)CONCAT31(puStack_8._1_3_,2);
    iVar4 = **(int **)((int)this + 8);
    pcVar3 = QByteArray::constData(this_00);
    iVar4 = (**(code **)(iVar4 + 0x98))(pcVar3,uVar6,pQVar7,uVar2);
    pQVar5 = (QString *)QString::fromUtf8((char *)aQStack_14,iVar4);
    uStack_4 = 3;
  }
  QString::QString(param_1,pQVar5);
  if (bVar1) {
    QString::~QString(aQStack_18);
  }
  uStack_4 = 2;
  if (!bVar1) {
    QString::~QString(aQStack_14);
  }
  uStack_4 = 1;
  if (!bVar1) {
    QByteArray::~QByteArray(aQStack_10);
  }
  uStack_4 = uStack_4 & 0xffffff00;
  QString::~QString((QString *)&pQStack_1c);
  ExceptionList = local_c;
  return param_1;
}



// WARNING: Function: __alloca_probe replaced with injection: alloca_probe

void __thiscall FUN_1000af10(void *this,undefined4 param_1)

{
  QString *this_00;
  undefined4 uStack_4028;
  uint uStack_4024;
  undefined1 auStack_401c [4];
  undefined4 local_4018;
  undefined4 local_4014;
  undefined1 local_4010 [16372];
  uint uStack_1c;
  void *pvStack_18;
  uint local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100126af;
  local_c = ExceptionList;
  local_10 = DAT_10022088 ^ (uint)auStack_401c;
  uStack_4024 = DAT_10022088 ^ (uint)&stack0xffffbfe0;
  ExceptionList = &local_c;
  local_4018 = 0;
  uStack_4028 = 0x4000;
  local_4014 = param_1;
  (**(code **)(**(int **)((int)this + 8) + 0x44))(local_4010);
  this_00 = (QString *)QString::fromLatin1((char *)&uStack_4024,(int)&local_4018);
  local_c = (void *)0x1;
  QString::trimmed(this_00);
  uStack_4024 = 1;
  local_10 = local_10 & 0xffffff00;
  QString::~QString((QString *)&uStack_4028);
  ExceptionList = pvStack_18;
  FUN_10010b2e(uStack_1c ^ (uint)&uStack_4028);
  return;
}



void __fastcall FUN_1000afe0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000afe5. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x38))();
  return;
}



undefined4 __fastcall FUN_1000aff0(int param_1)

{
  int iVar1;
  QString *this;
  undefined4 unaff_retaddr;
  undefined4 local_14;
  void *pvStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100125e3;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_14 = 0;
  iVar1 = (**(code **)(**(int **)(param_1 + 8) + 0x70))(0xffffffff,DAT_10022088 ^ (uint)&local_14);
  this = (QString *)QString::fromLatin1((char *)&pvStack_10,iVar1);
  uStack_4 = 1;
  QString::trimmed(this);
  puStack_8 = (undefined1 *)((uint)puStack_8 & 0xffffff00);
  QString::~QString((QString *)&local_14);
  ExceptionList = pvStack_10;
  return unaff_retaddr;
}



void __fastcall FUN_1000b080(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000b085. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x138))();
  return;
}



void __fastcall FUN_1000b090(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000b095. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0xfc))();
  return;
}



undefined1 __thiscall FUN_1000b0f0(void *this,undefined4 param_1,QString *param_2)

{
  int iVar1;
  undefined1 uVar2;
  uint uVar3;
  QByteArray *this_00;
  QByteArray *this_01;
  char *pcVar4;
  char *pcVar5;
  void *unaff_ESI;
  QString *unaff_retaddr;
  undefined4 *puVar6;
  void **ppvVar7;
  void *local_10;
  void *local_c;
  undefined1 *local_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  local_8 = &LAB_100126f2;
  local_c = ExceptionList;
  uVar3 = DAT_10022088 ^ (uint)&stack0xffffffe0;
  ExceptionList = &local_c;
  ppvVar7 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_2);
  puVar6 = &param_1;
  local_8 = (undefined1 *)0x0;
  this_01 = (QByteArray *)QString::toLatin1(unaff_retaddr);
  local_c = (void *)CONCAT31(local_c._1_3_,1);
  iVar1 = **(int **)((int)this + 8);
  pcVar4 = QByteArray::constData(this_00);
  pcVar5 = QByteArray::constData(this_01);
  uVar2 = (**(code **)(iVar1 + 0xbc))(pcVar5,pcVar4,puVar6,ppvVar7,uVar3);
  QByteArray::~QByteArray((QByteArray *)&local_8);
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe0);
  ExceptionList = unaff_ESI;
  return uVar2;
}



void __fastcall FUN_1000b1b0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000b1b8. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x10))();
  return;
}



void __fastcall FUN_1000b1c0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000b1c8. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x14))();
  return;
}



void __fastcall FUN_1000b1d0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000b1d8. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x18))();
  return;
}



void __fastcall FUN_1000b1e0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000b1eb. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x8c))();
  return;
}



void __fastcall FUN_1000b1f0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000b1f8. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x7c))();
  return;
}



void __fastcall FUN_1000b200(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000b208. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x78))();
  return;
}



char * __thiscall FUN_1000b210(void *this,undefined4 param_1,undefined4 param_2)

{
  int iVar1;
  char *unaff_retaddr;
  
  iVar1 = (**(code **)(**(int **)((int)this + 8) + 0x5c))(param_2,0xffffffff,0);
  QString::fromLatin1(unaff_retaddr,iVar1);
  return unaff_retaddr;
}



char * __thiscall FUN_1000b240(void *this,undefined4 param_1,undefined4 param_2)

{
  int iVar1;
  char *unaff_retaddr;
  
  iVar1 = (**(code **)(**(int **)((int)this + 8) + 0x60))(param_2,0xffffffff,0);
  QString::fromLatin1(unaff_retaddr,iVar1);
  return unaff_retaddr;
}



undefined4 __thiscall FUN_1000b270(void *this,QString *param_1)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  undefined4 uVar4;
  void *unaff_ESI;
  void **ppvVar5;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar5 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  uVar4 = (**(code **)(iVar1 + 100))(pcVar3,ppvVar5,uVar2);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return uVar4;
}



char * __thiscall FUN_1000b2f0(void *this,undefined4 param_1,QString *param_2)

{
  uint uVar1;
  QByteArray *this_00;
  char *pcVar2;
  int iVar3;
  undefined4 uVar4;
  undefined1 *puVar5;
  undefined1 local_10 [4];
  void *local_c;
  undefined1 *puStack_8;
  char *pcStack_4;
  
  pcStack_4 = (char *)0xffffffff;
  puStack_8 = &LAB_10012733;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffe4;
  ExceptionList = &local_c;
  puVar5 = local_10;
  this_00 = (QByteArray *)QString::toLatin1(param_2);
  uVar4 = 0xffffffff;
  puStack_8 = (undefined1 *)0x1;
  iVar3 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  iVar3 = (**(code **)(iVar3 + 0x54))(pcVar2,uVar4,puVar5,uVar1);
  pcVar2 = pcStack_4;
  QString::fromLatin1(pcStack_4,iVar3);
  local_c = (void *)((uint)local_c & 0xffffff00);
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = (void *)0x0;
  return pcVar2;
}



char * __thiscall FUN_1000b390(void *this,undefined4 param_1,QString *param_2)

{
  uint uVar1;
  QByteArray *this_00;
  char *pcVar2;
  int iVar3;
  undefined4 uVar4;
  undefined1 *puVar5;
  undefined1 local_10 [4];
  void *local_c;
  undefined1 *puStack_8;
  char *pcStack_4;
  
  pcStack_4 = (char *)0xffffffff;
  puStack_8 = &LAB_10012733;
  local_c = ExceptionList;
  uVar1 = DAT_10022088 ^ (uint)&stack0xffffffe4;
  ExceptionList = &local_c;
  puVar5 = local_10;
  this_00 = (QByteArray *)QString::toLatin1(param_2);
  uVar4 = 0xffffffff;
  puStack_8 = (undefined1 *)0x1;
  iVar3 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  iVar3 = (**(code **)(iVar3 + 0x58))(pcVar2,uVar4,puVar5,uVar1);
  pcVar2 = pcStack_4;
  QString::fromLatin1(pcStack_4,iVar3);
  local_c = (void *)((uint)local_c & 0xffffff00);
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = (void *)0x0;
  return pcVar2;
}



undefined4 * __fastcall FUN_1000b430(int param_1)

{
  QArrayData *pQVar1;
  int iVar2;
  QArrayData *_Dst;
  QArrayData *pQVar3;
  QString *pQVar4;
  QVariant *pQVar5;
  QTypedArrayData<> *this;
  undefined4 uVar6;
  QVariant *pQVar7;
  undefined4 *puVar8;
  QTypedArrayData<> *unaff_ESI;
  code *pcVar9;
  undefined1 *puStack_164;
  undefined4 uStack_160;
  void *this_00;
  QTypedArrayData<> *pQStack_138;
  QTypedArrayData<> *pQStack_134;
  uint uStack_130;
  QTypedArrayData<> *pQStack_11c;
  int iStack_118;
  int iStack_114;
  int local_110;
  undefined4 local_10c [2];
  QString aQStack_104 [4];
  QTypedArrayData<> *pQStack_100;
  QString aQStack_fc [4];
  QString aQStack_f8 [4];
  QString aQStack_f4 [8];
  QString aQStack_ec [4];
  QTypedArrayData<> *pQStack_e8;
  QArrayData *pQStack_dc;
  undefined4 uStack_d8;
  void *apvStack_d4 [2];
  undefined4 uStack_cc;
  undefined4 local_c8;
  QVariant aQStack_c4 [4];
  QVariant aQStack_c0 [4];
  undefined1 uStack_bc;
  undefined1 uStack_b8;
  QVariant aQStack_b4 [8];
  QVariant aQStack_ac [8];
  QVariant aQStack_a4 [32];
  QVariant aQStack_84 [24];
  undefined1 uStack_6c;
  void *apvStack_64 [3];
  undefined1 uStack_58;
  undefined1 uStack_54;
  undefined1 uStack_40;
  undefined1 uStack_3c;
  undefined1 uStack_28;
  void *pvStack_1c;
  undefined1 uStack_14;
  undefined4 *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  puStack_8 = &LAB_100128d8;
  local_c = (undefined4 *)ExceptionList;
  uStack_130 = DAT_10022088 ^ (uint)&stack0xfffffed4;
  ExceptionList = &local_c;
  local_c8 = 0;
  pQStack_138 = (QTypedArrayData<> *)local_10c;
  local_10c[0] = 0;
  pQStack_134 = (QTypedArrayData<> *)0x0;
  local_4 = 0;
  local_110 = param_1;
  (**(code **)(**(int **)(param_1 + 8) + 0x13c))();
  pQVar3 = (QArrayData *)shared_null_exref;
  if (0 < iStack_114) {
    pQVar3 = QArrayData::allocate();
    if (pQVar3 == (QArrayData *)0x0) {
      qBadAlloc();
    }
    *(int *)(pQVar3 + 4) = iStack_114;
    iVar2 = *(int *)(pQVar3 + 0xc);
    pQVar1 = pQVar3 + iVar2;
    param_1 = iStack_118;
    while (_Dst = pQVar1, _Dst != pQVar3 + iStack_114 * 0x8c + iVar2) {
      pQVar1 = _Dst + 0x8c;
      if (_Dst != (QArrayData *)0x0) {
        iStack_118 = param_1;
        memset(_Dst,0,0x8c);
        param_1 = iStack_118;
      }
    }
  }
  local_c = (undefined4 *)0x1;
  if ((*(int *)pQVar3 != 1) && (*(int *)pQVar3 != 0)) {
    if ((*(uint *)(pQVar3 + 8) & 0x7fffffff) == 0) {
      QArrayData::allocate();
    }
    else {
      FUN_1000d9b0(&stack0xfffffee0,*(int *)(pQVar3 + 4),*(uint *)(pQVar3 + 8) & 0x7fffffff,0);
    }
  }
  (**(code **)(**(int **)(param_1 + 8) + 0x13c))();
  puVar8 = local_c;
  *local_c = shared_null_exref;
  uStack_d8 = 1;
  pQVar3 = FUN_10009920((int *)&stack0xfffffed8);
  pQStack_dc = FUN_10009e50((int *)&stack0xfffffed8);
  if (pQVar3 != pQStack_dc) {
    apvStack_d4[0] = (void *)CONCAT31(apvStack_d4[0]._1_3_,0x20);
    uStack_b8 = 0x20;
    uStack_bc = 0x20;
    uStack_cc = CONCAT31(uStack_cc._1_3_,0x20);
    pQVar3 = pQVar3 + 0x84;
    pcVar9 = ~QVariant_exref;
    do {
      uStack_14 = 2;
      QString::fromUtf8(&stack0xfffffedc,(int)(pQVar3 + -0x84));
      uStack_14 = 3;
      pQStack_e8 = QString::fromAscii_helper("#%1_NAME",8);
      uStack_14 = 4;
      this_00 = apvStack_d4[0];
      QChar::QChar((QChar *)&stack0xfffffebc);
      pQVar4 = (QString *)QString::arg(aQStack_ec);
      uStack_28 = 5;
      uStack_160 = 0x1000b665;
      pQVar4 = FUN_1000adc0(pQStack_134,(QString *)apvStack_d4,pQVar4);
      uStack_28 = 6;
      QVariant::QVariant(aQStack_c0,pQVar4);
      uStack_28 = 7;
      uStack_160 = 0x1000b690;
      pQStack_100 = QString::fromAscii_helper((char *)&param_1_10014fb8,4);
      pQVar7 = aQStack_c0;
      uStack_28 = 8;
      uStack_160 = 0x1000b6b5;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffec0,(QString *)&pQStack_100);
      QVariant::operator=(pQVar5,pQVar7);
      uStack_28 = 7;
      QString::~QString((QString *)&pQStack_100);
      uStack_28 = 6;
      (*pcVar9)();
      uStack_28 = 5;
      QString::~QString((QString *)apvStack_d4);
      uStack_28 = 4;
      QString::~QString(aQStack_f8);
      uStack_28 = 3;
      QString::~QString(aQStack_fc);
      uStack_160 = 0x1000b726;
      unaff_ESI = QString::fromAscii_helper("#%1_DESC",8);
      uStack_28 = 9;
      uStack_160 = 0x1000b744;
      QChar::QChar((QChar *)&stack0xfffffea8);
      uStack_160 = 0;
      puStack_164 = &stack0xfffffec4;
      pQVar4 = (QString *)QString::arg((QString *)&stack0xfffffed4);
      uStack_3c = 10;
      pQVar4 = FUN_1000adc0(this_00,aQStack_f8,pQVar4);
      uStack_3c = 0xb;
      QVariant::QVariant(aQStack_84,pQVar4);
      uStack_3c = 0xc;
      pQStack_134 = QString::fromAscii_helper("description",0xb);
      pQVar7 = aQStack_84;
      uStack_3c = 0xd;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffeac,(QString *)&pQStack_134);
      QVariant::operator=(pQVar5,pQVar7);
      uStack_3c = 0xc;
      QString::~QString((QString *)&pQStack_134);
      uStack_3c = 0xb;
      (*pcVar9)();
      uStack_3c = 10;
      QString::~QString(aQStack_f8);
      uStack_3c = 9;
      QString::~QString((QString *)&uStack_d8);
      uStack_3c = 3;
      QString::~QString((QString *)&stack0xfffffec4);
      QVariant::QVariant(aQStack_a4,*(int *)(pQVar3 + -4));
      uStack_3c = 0xe;
      QString::fromAscii_helper("count",5);
      pQVar7 = aQStack_a4;
      uStack_3c = 0xf;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffeac,(QString *)&stack0xfffffed4);
      QVariant::operator=(pQVar5,pQVar7);
      uStack_3c = 0xe;
      QString::~QString((QString *)&stack0xfffffed4);
      uStack_3c = 3;
      (*pcVar9)();
      QVariant::QVariant((QVariant *)apvStack_64,*(int *)pQVar3);
      uStack_3c = 0x10;
      pQStack_11c = QString::fromAscii_helper((char *)&param_1_1001537c,4);
      pQVar7 = (QVariant *)apvStack_64;
      uStack_3c = 0x11;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffeac,(QString *)&pQStack_11c);
      QVariant::operator=(pQVar5,pQVar7);
      uStack_3c = 0x10;
      QString::~QString((QString *)&pQStack_11c);
      uStack_3c = 3;
      (*pcVar9)();
      QVariant::QVariant(aQStack_c4,(bool)pQVar3[4]);
      uStack_3c = 0x12;
      QString::fromAscii_helper("isAchieved",10);
      pQVar7 = aQStack_c4;
      uStack_3c = 0x13;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffeac,(QString *)&stack0xfffffedc);
      QVariant::operator=(pQVar5,pQVar7);
      uStack_3c = 0x12;
      QString::~QString((QString *)&stack0xfffffedc);
      uStack_3c = 3;
      (*pcVar9)();
      QVariant::QVariant(aQStack_b4,(bool)pQVar3[5]);
      uStack_3c = 0x14;
      pQStack_138 = QString::fromAscii_helper("shouldHideUntilAchieved",0x17);
      pQVar7 = aQStack_b4;
      uStack_3c = 0x15;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffeac,(QString *)&pQStack_138);
      QVariant::operator=(pQVar5,pQVar7);
      uStack_3c = 0x14;
      QString::~QString((QString *)&pQStack_138);
      uStack_3c = 3;
      (*pcVar9)();
      QString::toLower((QString *)&stack0xfffffeb4);
      uStack_40 = 0x16;
      this = QString::fromAscii_helper("image://game/materials/vgui/achievements/%1.vtf",0x2f);
      uStack_40 = 0x17;
      QChar::QChar((QChar *)&stack0xfffffe90);
      pQVar4 = (QString *)QString::arg((QString *)&uStack_130);
      uStack_54 = 0x18;
      QVariant::QVariant(aQStack_ac,pQVar4);
      uStack_54 = 0x19;
      QString::fromAscii_helper("imageSourceUnlocked",0x13);
      pQVar7 = aQStack_ac;
      uStack_54 = 0x1a;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffe94,(QString *)&stack0xfffffeb8);
      QVariant::operator=(pQVar5,pQVar7);
      uStack_54 = 0x19;
      QString::~QString((QString *)&stack0xfffffeb8);
      uStack_54 = 0x18;
      (*pcVar9)();
      uStack_54 = 0x17;
      QString::~QString(aQStack_104);
      uStack_54 = 0x16;
      QString::~QString((QString *)&stack0xfffffec0);
      uStack_54 = 3;
      QString::~QString(aQStack_f4);
      uVar6 = QString::toLower((QString *)&puStack_164);
      uStack_58 = 0x1b;
      pQStack_134 = QString::fromAscii_helper
                              ("image://game/materials/vgui/achievements/%1_bw.vtf",0x32);
      uStack_58 = 0x1c;
      QChar::QChar((QChar *)&stack0xfffffe78,local_110);
      pQVar4 = (QString *)QString::arg((QString *)&pQStack_138,&local_110,uVar6,0);
      uStack_6c = 0x1d;
      QVariant::QVariant(aQStack_a4,pQVar4);
      uStack_6c = 0x1e;
      QString::fromAscii_helper("imageSourceLocked",0x11);
      pQVar7 = aQStack_a4;
      uStack_6c = 0x1f;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffe7c,(QString *)&stack0xfffffeb0);
      QVariant::operator=(pQVar5,pQVar7);
      uStack_6c = 0x1e;
      QString::~QString((QString *)&stack0xfffffeb0);
      uStack_6c = 0x1d;
      (*pcVar9)();
      uStack_6c = 0x1c;
      QString::~QString((QString *)&stack0xfffffee0);
      uStack_6c = 0x1b;
      QString::~QString((QString *)&stack0xfffffeb8);
      uStack_6c = 3;
      QString::~QString((QString *)&pQStack_138);
      pQVar7 = FUN_10009130(aQStack_84,&stack0xfffffe7c);
      uStack_6c = 0x20;
      FUN_10009840(apvStack_64[0],pQVar7);
      uStack_6c = 3;
      (*pcVar9)();
      uStack_14 = 2;
      QString::~QString((QString *)&stack0xfffffedc);
      uStack_14 = 1;
      if (*(int *)this == 0) {
LAB_1000bc7d:
        iVar2 = *(int *)(this + 0xc);
        if (iVar2 != 0) {
          QString::~QString((QString *)(iVar2 + 0xc));
          QVariant::~QVariant((QVariant *)(iVar2 + 0x10));
          if (*(int *)(iVar2 + 4) != 0) {
            FUN_100041f0(*(int *)(iVar2 + 4));
          }
          if (*(int *)(iVar2 + 8) != 0) {
            FUN_100041f0(*(int *)(iVar2 + 8));
          }
          QMapDataBase::freeTree((QMapDataBase *)this,*(QMapNodeBase **)(this + 0xc),8);
        }
        QMapDataBase::freeData((QMapDataBase *)this);
        pcVar9 = ~QVariant_exref;
      }
      else if (*(int *)this != -1) {
        LOCK();
        iVar2 = *(int *)this;
        *(int *)this = iVar2 + -1;
        UNLOCK();
        if (iVar2 + -1 == 0) goto LAB_1000bc7d;
      }
      pQVar1 = pQVar3 + 8;
      puVar8 = local_c;
      pQVar3 = pQVar3 + 0x8c;
    } while (pQVar1 != pQStack_dc);
  }
  if (*(int *)unaff_ESI != 0) {
    if (*(int *)unaff_ESI == -1) {
      ExceptionList = pvStack_1c;
      return puVar8;
    }
    LOCK();
    iVar2 = *(int *)unaff_ESI;
    *(int *)unaff_ESI = *(int *)unaff_ESI + -1;
    UNLOCK();
    if (iVar2 != 1) {
      ExceptionList = pvStack_1c;
      return puVar8;
    }
  }
  QArrayData::deallocate((QArrayData *)unaff_ESI,0x8c,4);
  ExceptionList = pvStack_1c;
  return puVar8;
}



QJsonArray * __thiscall FUN_1000bd40(void *this,QJsonArray *param_1)

{
  QString *pQVar1;
  int iVar2;
  QJsonArray *pQVar3;
  code *pcVar4;
  char cVar5;
  bool bVar6;
  QByteArray *this_00;
  char *pcVar7;
  char *pcVar8;
  QJsonParseError *pQVar9;
  int *piVar10;
  undefined4 *puVar11;
  Data *unaff_EBP;
  QString *this_01;
  Data *this_02;
  undefined1 *puVar12;
  QByteArray *pQVar13;
  int *piStack_78;
  QString aQStack_74 [4];
  void *local_70;
  QJsonDocument aQStack_6c [4];
  QTypedArrayData<> *pQStack_68;
  QTypedArrayData<> *pQStack_64;
  QTypedArrayData<> *pQStack_60;
  QTypedArrayData<> *pQStack_5c;
  QByteArray *pQStack_58;
  undefined4 local_54;
  undefined1 auStack_50 [4];
  undefined4 uStack_4c;
  QByteArray aQStack_48 [4];
  QJsonObject aQStack_44 [8];
  QString aQStack_3c [4];
  QJsonValue aQStack_38 [16];
  QJsonValue aQStack_28 [4];
  QJsonValue aQStack_24 [16];
  void *pvStack_14;
  undefined1 uStack_10;
  void *local_c;
  QJsonArray *pQStack_8;
  undefined4 local_4;
  
  pQStack_8 = (QJsonArray *)&LAB_10012997;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_54 = 0;
  local_4 = 0;
  local_70 = this;
  QJsonArray::QJsonArray(param_1);
  pcVar4 = fromAscii_helper_exref;
  local_4 = 0;
  local_54 = 1;
  pQStack_64 = QString::fromAscii_helper((char *)&param_1_10015194,4);
  local_4 = 1;
  pQStack_68 = QString::fromAscii_helper("campaigns/*.json",0x10);
  local_4._0_1_ = 2;
  FUN_1000c3f0(this,(QString *)&piStack_78,&pQStack_68,(QString *)&pQStack_64);
  local_4._0_1_ = 4;
  QString::~QString((QString *)&pQStack_68);
  local_4 = CONCAT31(local_4._1_3_,5);
  QString::~QString((QString *)&pQStack_64);
  if ((*piStack_78 != 1) && (*piStack_78 != 0)) {
    FUN_10009c10(&piStack_78,piStack_78[1]);
  }
  this_01 = (QString *)(piStack_78 + piStack_78[2] + 4);
  if ((*piStack_78 != 1) && (*piStack_78 != 0)) {
    FUN_10009c10(&piStack_78,piStack_78[1]);
  }
  pQVar1 = (QString *)(piStack_78 + piStack_78[3] + 4);
  for (; this_01 != pQVar1; this_01 = this_01 + 4) {
    pQStack_60 = (QTypedArrayData<> *)(*pcVar4)(&param_1_10015194,4);
    pQVar13 = aQStack_48;
    local_4._0_1_ = 6;
    local_54 = QString::toLatin1((QString *)&pQStack_60);
    puVar12 = auStack_50;
    pQStack_8 = (QJsonArray *)CONCAT31(pQStack_8._1_3_,7);
    this_00 = (QByteArray *)QString::toLatin1(this_01);
    local_c = (void *)CONCAT31(local_c._1_3_,8);
    iVar2 = *(int *)piStack_78[2];
    pcVar7 = QByteArray::constData(pQStack_58);
    pcVar8 = QByteArray::constData(this_00);
    cVar5 = (**(code **)(iVar2 + 0xbc))(pcVar8,pcVar7,puVar12,pQVar13);
    local_4._0_1_ = 7;
    QByteArray::~QByteArray((QByteArray *)&uStack_4c);
    local_4._0_1_ = 6;
    QByteArray::~QByteArray(aQStack_48);
    local_4 = CONCAT31(local_4._1_3_,5);
    QString::~QString((QString *)&pQStack_60);
    pcVar4 = fromAscii_helper_exref;
    if (cVar5 == '\0') {
      pQStack_5c = QString::fromAscii_helper((char *)&param_1_10015194,4);
      local_4._0_1_ = 9;
      FUN_1000d860(local_70,aQStack_74,this_01,(QString *)&pQStack_5c);
      local_4 = CONCAT31(local_4._1_3_,0xb);
      QString::~QString((QString *)&pQStack_5c);
      bVar6 = QString::isNull(aQStack_74);
      if (!bVar6) {
        pQVar9 = (QJsonParseError *)QString::toUtf8(aQStack_74);
        pQStack_8._0_1_ = 0xc;
        QJsonDocument::fromJson((QByteArray *)&local_70,pQVar9);
        pQStack_8 = (QJsonArray *)CONCAT31(pQStack_8._1_3_,0xe);
        QByteArray::~QByteArray(aQStack_48);
        bVar6 = QJsonDocument::isObject((QJsonDocument *)&local_70);
        if (bVar6) {
          QJsonDocument::object((QJsonDocument *)&local_70);
          local_c._0_1_ = 0xf;
          pQStack_60 = QString::fromAscii_helper("isOfficial",10);
          local_c._0_1_ = 0x10;
          bVar6 = QString::operator==(this_01,"campaigns/blackmesa.json");
          QJsonValue::QJsonValue(aQStack_24,bVar6);
          local_c = (void *)CONCAT31(local_c._1_3_,0x11);
          QJsonObject::insert(aQStack_44,aQStack_3c,(QJsonValue *)&pQStack_60);
          uStack_10 = 0x10;
          QJsonValue::~QJsonValue(aQStack_28);
          uStack_10 = 0xf;
          QString::~QString((QString *)&pQStack_64);
          QJsonValue::QJsonValue(aQStack_38,(QJsonObject *)aQStack_48);
          uStack_10 = 0x12;
          QJsonArray::append(pQStack_8,aQStack_38);
          uStack_10 = 0xf;
          QJsonValue::~QJsonValue(aQStack_38);
          uStack_10 = 0xe;
          QJsonObject::~QJsonObject((QJsonObject *)aQStack_48);
        }
        local_4 = CONCAT31(local_4._1_3_,0xb);
        QJsonDocument::~QJsonDocument(aQStack_6c);
      }
      local_4 = CONCAT31(local_4._1_3_,5);
      QString::~QString(aQStack_74);
    }
  }
  piVar10 = (int *)QJsonArray::end(param_1);
  iVar2 = *piVar10;
  pQVar3 = (QJsonArray *)piVar10[1];
  puVar11 = (undefined4 *)QJsonArray::begin(param_1);
  uStack_4c = *puVar11;
  FUN_10008790((QJsonArray *)*puVar11,(QJsonArray *)puVar11[1],iVar2,pQVar3,(int)pQVar3 - puVar11[1]
               ,local_4);
  local_c = (void *)((uint)local_c & 0xffffff00);
  if (*(int *)unaff_EBP != 0) {
    if (*(int *)unaff_EBP == -1) {
      ExceptionList = pvStack_14;
      return param_1;
    }
    LOCK();
    iVar2 = *(int *)unaff_EBP;
    *(int *)unaff_EBP = iVar2 + -1;
    UNLOCK();
    if (iVar2 + -1 != 0) {
      ExceptionList = pvStack_14;
      return param_1;
    }
  }
  iVar2 = *(int *)(unaff_EBP + 8);
  this_02 = unaff_EBP + (*(int *)(unaff_EBP + 0xc) + 4) * 4;
  while (unaff_EBP + (iVar2 + 4) * 4 != this_02) {
    this_02 = this_02 + -4;
    QString::~QString((QString *)this_02);
  }
  QListData::dispose(unaff_EBP);
  ExceptionList = pvStack_14;
  return param_1;
}



void * __thiscall FUN_1000c190(void *this,undefined4 param_1,QString *param_2)

{
  char cVar1;
  void *pvVar2;
  char *pcVar3;
  QByteArray *this_00;
  char *pcVar4;
  char *pcVar5;
  int iVar6;
  undefined4 uVar7;
  QString *pQVar8;
  uint uStack_28;
  QString local_18 [4];
  uint local_14;
  void *local_c;
  QTypedArrayData<> *pQStack_8;
  undefined4 local_4;
  
  pQStack_8 = (QTypedArrayData<> *)&LAB_100129eb;
  local_c = ExceptionList;
  uStack_28 = DAT_10022088 ^ (uint)&stack0xffffffdc;
  ExceptionList = &local_c;
  local_4 = 0;
  local_14 = 0;
  pcVar3 = (char *)FUN_10010a18(0x400000);
  pQVar8 = local_18;
  this_00 = (QByteArray *)QString::toLatin1(param_2);
  uVar7 = 0x400000;
  pQStack_8 = (QTypedArrayData<> *)0x1;
  iVar6 = **(int **)((int)this + 8);
  pcVar5 = pcVar3;
  pcVar4 = QByteArray::constData(this_00);
  (**(code **)(iVar6 + 0xec))(pcVar4,pcVar5,uVar7);
  local_14 = local_14 & 0xffffff00;
  QByteArray::~QByteArray((QByteArray *)&uStack_28);
  if (pcVar3 == (char *)0x0) {
    iVar6 = -1;
  }
  else {
    pcVar5 = pcVar3;
    do {
      cVar1 = *pcVar5;
      pcVar5 = pcVar5 + 1;
    } while (cVar1 != '\0');
    iVar6 = (int)pcVar5 - (int)(pcVar3 + 1);
  }
  pQStack_8 = QString::fromAscii_helper(pcVar3,iVar6);
  pvVar2 = local_c;
  local_14 = 2;
  QString::split((QString *)&pQStack_8,local_c,10,1,1);
  QString::~QString(local_18);
  operator_delete__(pcVar3);
  ExceptionList = pQVar8;
  return pvVar2;
}



undefined4 __thiscall FUN_1000c2a0(void *this,QString *param_1,undefined4 param_2,QString *param_3)

{
  char cVar1;
  QByteArray *this_00;
  QByteArray *this_01;
  char *pcVar2;
  char *pcVar3;
  int iVar4;
  undefined4 unaff_EBP;
  undefined4 uVar5;
  int *piVar6;
  char *pcVar7;
  uint uStack_30;
  int local_1c [2];
  undefined4 local_14;
  undefined4 local_10;
  QTypedArrayData<> *local_c;
  undefined1 *local_8;
  undefined4 local_4;
  
  local_8 = &LAB_10012a44;
  local_c = (QTypedArrayData<> *)ExceptionList;
  uStack_30 = DAT_10022088 ^ (uint)&stack0xffffffd4;
  ExceptionList = &local_c;
  local_4 = 0;
  local_10 = 0;
  local_1c[0] = FUN_10010a18(0x400000);
  pcVar7 = (char *)&local_14;
  this_00 = (QByteArray *)QString::toLatin1(param_3);
  piVar6 = local_1c;
  local_8 = (undefined1 *)0x1;
  this_01 = (QByteArray *)QString::toLatin1(param_1);
  uVar5 = 0x400000;
  local_c = (QTypedArrayData<> *)CONCAT31(local_c._1_3_,2);
  iVar4 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  pcVar3 = QByteArray::constData(this_01);
  (**(code **)(iVar4 + 0xf0))(pcVar3,pcVar2,unaff_EBP,uVar5,piVar6);
  local_1c[0]._0_1_ = (QString)0x1;
  QByteArray::~QByteArray((QByteArray *)&uStack_30);
  local_1c[0] = (uint)local_1c[0]._1_3_ << 8;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffd4);
  if (pcVar7 == (char *)0x0) {
    iVar4 = -1;
  }
  else {
    pcVar2 = pcVar7;
    do {
      cVar1 = *pcVar2;
      pcVar2 = pcVar2 + 1;
    } while (cVar1 != '\0');
    iVar4 = (int)pcVar2 - (int)(pcVar7 + 1);
  }
  pcVar2 = pcVar7;
  local_c = QString::fromAscii_helper(pcVar7,iVar4);
  local_1c[0] = 3;
  QString::split((QString *)&local_c,local_14,10,1,1);
  QString::~QString((QString *)local_1c);
  operator_delete__(pcVar7);
  ExceptionList = pcVar2;
  return local_14;
}



undefined4 __thiscall FUN_1000c3f0(void *this,QString *param_1,undefined4 param_2,QString *param_3)

{
  char cVar1;
  QByteArray *this_00;
  QByteArray *this_01;
  char *pcVar2;
  char *pcVar3;
  char *pcVar4;
  int iVar5;
  char *unaff_EBP;
  undefined4 uVar6;
  int *piVar7;
  undefined4 *puVar8;
  uint uStack_30;
  int local_1c [2];
  undefined4 local_14;
  undefined4 local_10;
  QTypedArrayData<> *local_c;
  undefined1 *local_8;
  undefined4 local_4;
  
  local_8 = &LAB_10012a44;
  local_c = (QTypedArrayData<> *)ExceptionList;
  uStack_30 = DAT_10022088 ^ (uint)&stack0xffffffd4;
  ExceptionList = &local_c;
  local_4 = 0;
  local_10 = 0;
  local_1c[0] = FUN_10010a18(0x100000);
  puVar8 = &local_14;
  this_00 = (QByteArray *)QString::toLatin1(param_3);
  piVar7 = local_1c;
  local_8 = (undefined1 *)0x1;
  this_01 = (QByteArray *)QString::toLatin1(param_1);
  local_c = (QTypedArrayData<> *)CONCAT31(local_c._1_3_,2);
  iVar5 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  uVar6 = 0x100000;
  pcVar4 = unaff_EBP;
  pcVar3 = QByteArray::constData(this_01);
  (**(code **)(iVar5 + 0xc0))(pcVar3,pcVar4,uVar6,pcVar2,piVar7);
  local_1c[0]._0_1_ = (QString)0x1;
  QByteArray::~QByteArray((QByteArray *)&uStack_30);
  local_1c[0] = (uint)local_1c[0]._1_3_ << 8;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffd4);
  if (unaff_EBP == (char *)0x0) {
    iVar5 = -1;
  }
  else {
    pcVar4 = unaff_EBP;
    do {
      cVar1 = *pcVar4;
      pcVar4 = pcVar4 + 1;
    } while (cVar1 != '\0');
    iVar5 = (int)pcVar4 - (int)(unaff_EBP + 1);
  }
  local_c = QString::fromAscii_helper(unaff_EBP,iVar5);
  local_1c[0] = 3;
  QString::split((QString *)&local_c,local_14,0x3a,1,1);
  QString::~QString((QString *)local_1c);
  operator_delete__(unaff_EBP);
  ExceptionList = puVar8;
  return local_14;
}



undefined4 * __fastcall FUN_1000c540(QTypedArrayData<> *param_1)

{
  QArrayData QVar1;
  QArrayData *pQVar2;
  QArrayData *pQVar3;
  int iVar4;
  QFileInfo *this;
  QVariant *pQVar5;
  QDateTime *pQVar6;
  QTypedArrayData<> *pQVar7;
  undefined4 uVar8;
  QVariant *pQVar9;
  QArrayData *pQVar10;
  code *pcVar11;
  undefined4 *puVar12;
  QTypedArrayData<> *unaff_ESI;
  code *pcVar13;
  undefined4 *puStack_118;
  undefined4 uStack_114;
  uint uStack_110;
  QTypedArrayData<> *pQStack_fc;
  QTypedArrayData<> *pQStack_f8;
  QTypedArrayData<> *local_f4;
  undefined4 local_f0;
  QTypedArrayData<> *pQStack_ec;
  QString aQStack_e8 [4];
  QTypedArrayData<> *pQStack_e4;
  QTypedArrayData<> *pQStack_e0;
  QString aQStack_d8 [4];
  QTypedArrayData<> *pQStack_d4;
  QString aQStack_d0 [4];
  QTypedArrayData<> *pQStack_cc;
  QFileInfo aQStack_c8 [4];
  undefined1 uStack_c4;
  QArrayData *pQStack_b8;
  undefined4 auStack_b4 [2];
  QVariant aQStack_ac [8];
  undefined4 local_a4;
  QVariant aQStack_9c [20];
  QVariant aQStack_88 [12];
  QVariant aQStack_7c [8];
  QVariant aQStack_74 [20];
  QVariant aQStack_60 [12];
  QVariant aQStack_54 [8];
  QVariant aQStack_4c [16];
  undefined1 uStack_3c;
  undefined1 uStack_38;
  void *pvStack_34;
  undefined1 uStack_24;
  undefined1 uStack_20;
  void *pvStack_1c;
  undefined1 uStack_18;
  undefined1 uStack_14;
  undefined4 *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  puStack_8 = &LAB_10012bb8;
  local_c = (undefined4 *)ExceptionList;
  uStack_110 = DAT_10022088 ^ (uint)&stack0xfffffef4;
  ExceptionList = &local_c;
  local_a4 = 0;
  puStack_118 = &local_f0;
  local_f0 = 0;
  uStack_114 = 0;
  local_4 = 0;
  local_f4 = param_1;
  (**(code **)(**(int **)(param_1 + 8) + 0x10c))();
  pQVar7 = pQStack_f8;
  pQVar2 = (QArrayData *)shared_null_exref;
  if (0 < (int)pQStack_f8) {
    pQVar2 = QArrayData::allocate();
    if (pQVar2 == (QArrayData *)0x0) {
      qBadAlloc();
    }
    *(QTypedArrayData<> **)(pQVar2 + 4) = pQVar7;
    iVar4 = *(int *)(pQVar2 + 0xc);
    pQVar3 = pQVar2 + iVar4;
    param_1 = pQStack_fc;
    while (pQVar10 = pQVar3, pQStack_fc = param_1, pQVar10 != pQVar2 + (int)pQVar7 * 0x20c + iVar4)
    {
      pQVar3 = pQVar10 + 0x20c;
      if (pQVar10 != (QArrayData *)0x0) {
        memset(pQVar10,0,0x20c);
        param_1 = pQStack_fc;
      }
    }
  }
  local_c = (undefined4 *)0x1;
  if ((*(int *)pQVar2 != 1) && (*(int *)pQVar2 != 0)) {
    if ((*(uint *)(pQVar2 + 8) & 0x7fffffff) == 0) {
      QArrayData::allocate();
    }
    else {
      FUN_1000dd10(&stack0xffffff00,*(int *)(pQVar2 + 4),*(uint *)(pQVar2 + 8) & 0x7fffffff,0);
    }
  }
  (**(code **)(**(int **)(param_1 + 8) + 0x10c))();
  puVar12 = local_c;
  *local_c = shared_null_exref;
  auStack_b4[0] = 1;
  pQVar2 = FUN_100099e0((int *)&stack0xfffffef8);
  pQStack_b8 = FUN_10009f30((int *)&stack0xfffffef8);
  if (pQVar2 != pQStack_b8) {
    uStack_c4 = 0x20;
    pcVar11 = ~QVariant_exref;
    do {
      pcVar13 = QVariant_exref;
      uStack_14 = 2;
      if (pQVar2 == (QArrayData *)0x0) {
        iVar4 = -1;
      }
      else {
        pQVar3 = pQVar2;
        do {
          QVar1 = *pQVar3;
          pQVar3 = pQVar3 + 1;
        } while (QVar1 != (QArrayData)0x0);
        iVar4 = (int)pQVar3 - (int)(pQVar2 + 1);
      }
      pQStack_cc = QString::fromAscii_helper((char *)pQVar2,iVar4);
      uStack_14 = 3;
      this = (QFileInfo *)QFileInfo::QFileInfo(aQStack_c8,(QString *)&pQStack_cc);
      uStack_14 = 4;
      QFileInfo::baseName(this);
      uStack_18 = 6;
      QFileInfo::~QFileInfo((QFileInfo *)&pQStack_cc);
      uStack_18 = 7;
      QString::~QString(aQStack_d0);
      QVariant::QVariant(aQStack_60,(QString *)&stack0xfffffef8);
      uStack_18 = 8;
      pQStack_e4 = QString::fromAscii_helper((char *)&param_1_10014fb8,4);
      pQVar9 = aQStack_60;
      uStack_18 = 9;
      pQVar5 = (QVariant *)FUN_10003770(&uStack_110,(QString *)&pQStack_e4);
      QVariant::operator=(pQVar5,pQVar9);
      uStack_18 = 8;
      QString::~QString((QString *)&pQStack_e4);
      uStack_18 = 7;
      (*pcVar11)();
      pQVar3 = pQVar2 + 0x80;
      if (pQVar3 == (QArrayData *)0x0) {
        iVar4 = -1;
      }
      else {
        pQVar10 = pQVar3;
        do {
          QVar1 = *pQVar10;
          pQVar10 = pQVar10 + 1;
        } while (QVar1 != (QArrayData)0x0);
        iVar4 = (int)pQVar10 - (int)(pQVar2 + 0x81);
        pcVar13 = QVariant_exref;
      }
      pQStack_d4 = QString::fromAscii_helper((char *)pQVar3,iVar4);
      uStack_18 = 10;
      (*pcVar13)();
      pvStack_1c._0_1_ = 0xb;
      pQStack_f8 = QString::fromAscii_helper("comment",7);
      pQVar9 = (QVariant *)auStack_b4;
      pvStack_1c._0_1_ = 0xc;
      pQVar5 = (QVariant *)FUN_10003770(&uStack_114,(QString *)&pQStack_f8);
      QVariant::operator=(pQVar5,pQVar9);
      pvStack_1c._0_1_ = 0xb;
      QString::~QString((QString *)&pQStack_f8);
      pvStack_1c._0_1_ = 10;
      (*pcVar11)();
      pvStack_1c._0_1_ = 7;
      QString::~QString(aQStack_d8);
      pQVar3 = pQVar2 + 0x100;
      if (pQVar3 == (QArrayData *)0x0) {
        iVar4 = -1;
      }
      else {
        pQVar10 = pQVar3;
        do {
          QVar1 = *pQVar10;
          pQVar10 = pQVar10 + 1;
        } while (QVar1 != (QArrayData)0x0);
        iVar4 = (int)pQVar10 - (int)(pQVar2 + 0x101);
        pcVar13 = QVariant_exref;
      }
      pQStack_e0 = QString::fromAscii_helper((char *)pQVar3,iVar4);
      pvStack_1c = (void *)CONCAT31(pvStack_1c._1_3_,0xd);
      (*pcVar13)();
      uStack_20 = 0xe;
      local_f4 = QString::fromAscii_helper((char *)&param_1_10014fc0,3);
      pQVar9 = aQStack_88;
      uStack_20 = 0xf;
      pQVar5 = (QVariant *)FUN_10003770(&puStack_118,(QString *)&local_f4);
      QVariant::operator=(pQVar5,pQVar9);
      uStack_20 = 0xe;
      QString::~QString((QString *)&local_f4);
      uStack_20 = 0xd;
      (*pcVar11)();
      uStack_20 = 7;
      QString::~QString((QString *)&pQStack_e4);
      pQVar3 = pQVar2 + 0x180;
      if (pQVar3 == (QArrayData *)0x0) {
        iVar4 = -1;
      }
      else {
        pQVar10 = pQVar3;
        do {
          QVar1 = *pQVar10;
          pQVar10 = pQVar10 + 1;
        } while (QVar1 != (QArrayData)0x0);
        iVar4 = (int)pQVar10 - (int)(pQVar2 + 0x181);
        pcVar13 = QVariant_exref;
      }
      QString::fromAscii_helper((char *)pQVar3,iVar4);
      uStack_20 = 0x10;
      (*pcVar13)();
      uStack_24 = 0x11;
      unaff_ESI = QString::fromAscii_helper("chapter",7);
      pQVar9 = aQStack_4c;
      uStack_24 = 0x12;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffee4,(QString *)&stack0xfffffef8);
      QVariant::operator=(pQVar5,pQVar9);
      uStack_24 = 0x11;
      QString::~QString((QString *)&stack0xfffffef8);
      uStack_24 = 0x10;
      (*pcVar11)();
      uStack_24 = 7;
      QString::~QString((QString *)&stack0xfffffefc);
      QVariant::QVariant(aQStack_ac,*(int *)(pQVar2 + 0x200));
      uStack_24 = 0x13;
      pQStack_fc = QString::fromAscii_helper("elapsedSeconds",0xe);
      pQVar9 = aQStack_ac;
      uStack_24 = 0x14;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffee4,(QString *)&pQStack_fc);
      QVariant::operator=(pQVar5,pQVar9);
      uStack_24 = 0x13;
      QString::~QString((QString *)&pQStack_fc);
      uStack_24 = 7;
      (*pcVar11)();
      pQVar6 = (QDateTime *)
               QDateTime::fromSecsSinceEpoch
                         (CONCAT44(*(undefined4 *)(pQVar2 + 0x204),&pQStack_cc),0,0);
      uStack_24 = 0x15;
      QVariant::QVariant(aQStack_9c,pQVar6);
      uStack_24 = 0x16;
      local_f4 = QString::fromAscii_helper("dateCreated",0xb);
      pQVar9 = aQStack_9c;
      uStack_24 = 0x17;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffee4,(QString *)&local_f4);
      QVariant::operator=(pQVar5,pQVar9);
      uStack_24 = 0x16;
      QString::~QString((QString *)&local_f4);
      uStack_24 = 0x15;
      (*pcVar11)();
      uStack_24 = 7;
      QDateTime::~QDateTime((QDateTime *)&pQStack_cc);
      QVariant::QVariant(aQStack_7c,*(uint *)(pQVar2 + 0x208));
      uStack_24 = 0x18;
      pQStack_ec = QString::fromAscii_helper("fileSize",8);
      pQVar9 = aQStack_7c;
      uStack_24 = 0x19;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffee4,(QString *)&pQStack_ec);
      QVariant::operator=(pQVar5,pQVar9);
      uStack_24 = 0x18;
      QString::~QString((QString *)&pQStack_ec);
      uStack_24 = 7;
      (*pcVar11)();
      pQVar7 = QString::fromAscii_helper("image://game/save/%1.tga",0x18);
      uStack_24 = 0x1a;
      QChar::QChar((QChar *)&stack0xfffffecc,pQStack_d4);
      uVar8 = QString::arg((QString *)&uStack_110,&pQStack_d4,&puStack_118,0);
      uStack_38 = 0x1b;
      (*pcVar13)(uVar8);
      uStack_3c = 0x1c;
      pQStack_fc = QString::fromAscii_helper("thumbnailUrl",0xc);
      pQVar9 = aQStack_74;
      uStack_3c = 0x1d;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xfffffecc,(QString *)&pQStack_fc);
      QVariant::operator=(pQVar5,pQVar9);
      uStack_3c = 0x1c;
      QString::~QString((QString *)&pQStack_fc);
      uStack_3c = 0x1b;
      (*pcVar11)();
      uStack_3c = 0x1a;
      QString::~QString(aQStack_e8);
      uStack_3c = 7;
      QString::~QString((QString *)&stack0xfffffedc);
      pQVar9 = FUN_10009130(aQStack_54,&stack0xfffffecc);
      uStack_3c = 0x1e;
      FUN_10009840(pvStack_34,pQVar9);
      uStack_3c = 7;
      (*pcVar11)();
      uStack_14 = 2;
      QString::~QString((QString *)&stack0xfffffefc);
      uStack_14 = 1;
      if (*(int *)pQVar7 == 0) {
LAB_1000cccb:
        iVar4 = *(int *)(pQVar7 + 0xc);
        if (iVar4 != 0) {
          QString::~QString((QString *)(iVar4 + 0xc));
          QVariant::~QVariant((QVariant *)(iVar4 + 0x10));
          if (*(int *)(iVar4 + 4) != 0) {
            FUN_100041f0(*(int *)(iVar4 + 4));
          }
          if (*(int *)(iVar4 + 8) != 0) {
            FUN_100041f0(*(int *)(iVar4 + 8));
          }
          QMapDataBase::freeTree((QMapDataBase *)pQVar7,*(QMapNodeBase **)(pQVar7 + 0xc),8);
        }
        QMapDataBase::freeData((QMapDataBase *)pQVar7);
        pcVar11 = ~QVariant_exref;
      }
      else if (*(int *)pQVar7 != -1) {
        LOCK();
        iVar4 = *(int *)pQVar7;
        *(int *)pQVar7 = iVar4 + -1;
        UNLOCK();
        if (iVar4 + -1 == 0) goto LAB_1000cccb;
      }
      pQVar2 = pQVar2 + 0x20c;
      puVar12 = local_c;
    } while (pQVar2 != pQStack_b8);
  }
  if (*(int *)unaff_ESI != 0) {
    if (*(int *)unaff_ESI == -1) {
      ExceptionList = pvStack_1c;
      return puVar12;
    }
    LOCK();
    iVar4 = *(int *)unaff_ESI;
    *(int *)unaff_ESI = *(int *)unaff_ESI + -1;
    UNLOCK();
    if (iVar4 != 1) {
      ExceptionList = pvStack_1c;
      return puVar12;
    }
  }
  QArrayData::deallocate((QArrayData *)unaff_ESI,0x20c,4);
  ExceptionList = pvStack_1c;
  return puVar12;
}



undefined4 * __fastcall FUN_1000cd90(int param_1)

{
  QArrayData *pQVar1;
  int iVar2;
  code *this;
  QTypedArrayData<> *pQVar3;
  QArrayData *pQVar4;
  QVariant *pQVar5;
  QVariant *pQVar6;
  QArrayData *unaff_EDI;
  undefined4 *this_00;
  QTypedArrayData<> *pQStack_80;
  QTypedArrayData<> *pQStack_7c;
  QTypedArrayData<> *local_78;
  undefined4 uStack_74;
  QArrayData *pQStack_70;
  QVariant aQStack_6c [8];
  undefined4 local_64;
  QVariant aQStack_5c [16];
  QVariant aQStack_4c [16];
  QVariant aQStack_3c [16];
  QVariant aQStack_2c [16];
  void *pvStack_1c;
  undefined1 uStack_14;
  undefined4 *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  puStack_8 = &LAB_10012c5a;
  local_c = (undefined4 *)ExceptionList;
  ExceptionList = &local_c;
  local_64 = 0;
  local_78 = (QTypedArrayData<> *)0x0;
  local_4 = 0;
  (**(code **)(**(int **)(param_1 + 8) + 0x80))(&local_78,0,DAT_10022088 ^ (uint)&stack0xffffff70);
  pQVar3 = pQStack_80;
  pQVar4 = (QArrayData *)shared_null_exref;
  if (0 < (int)pQStack_80) {
    pQVar4 = QArrayData::allocate(0x10,4,pQStack_80,0);
    if (pQVar4 == (QArrayData *)0x0) {
      qBadAlloc();
    }
    *(QTypedArrayData<> **)(pQVar4 + 4) = pQVar3;
    FUN_10009bd0((undefined4 *)(pQVar4 + *(int *)(pQVar4 + 0xc)),
                 (undefined4 *)(pQVar4 + (int)pQVar3 * 0x10 + *(int *)(pQVar4 + 0xc)));
  }
  local_c = (undefined4 *)0x1;
  if ((*(int *)pQVar4 != 1) && (*(int *)pQVar4 != 0)) {
    if ((*(uint *)(pQVar4 + 8) & 0x7fffffff) == 0) {
      pQVar4 = QArrayData::allocate(0x10,4,0,2);
    }
    else {
      FUN_1000ded0(&stack0xffffff78,*(int *)(pQVar4 + 4),*(uint *)(pQVar4 + 8) & 0x7fffffff,0);
    }
  }
  (**(code **)(**(int **)(param_1 + 8) + 0x80))(&pQStack_80,pQVar4 + *(int *)(pQVar4 + 0xc));
  this_00 = local_c;
  *local_c = shared_null_exref;
  uStack_74 = 1;
  if ((*(int *)pQVar4 != 1) && (*(int *)pQVar4 != 0)) {
    if ((*(uint *)(pQVar4 + 8) & 0x7fffffff) == 0) {
      unaff_EDI = QArrayData::allocate(0x10,4,0,2);
      pQVar4 = unaff_EDI;
    }
    else {
      FUN_1000ded0(&stack0xffffff70,*(int *)(pQVar4 + 4),*(uint *)(pQVar4 + 8) & 0x7fffffff,0);
      pQVar4 = unaff_EDI;
    }
  }
  iVar2 = *(int *)(pQVar4 + 0xc);
  pQStack_70 = FUN_10009fa0((int *)&stack0xffffff70);
  if (pQVar4 + iVar2 != pQStack_70) {
    pQVar4 = pQVar4 + iVar2 + 8;
    do {
      this = shared_null_exref;
      uStack_14 = 2;
      QVariant::QVariant(aQStack_6c,*(int *)(pQVar4 + -8));
      uStack_14 = 3;
      QString::fromAscii_helper("width",5);
      pQVar6 = aQStack_6c;
      uStack_14 = 4;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xffffff74,(QString *)&stack0xffffff7c);
      QVariant::operator=(pQVar5,pQVar6);
      uStack_14 = 3;
      QString::~QString((QString *)&stack0xffffff7c);
      uStack_14 = 2;
      QVariant::~QVariant(aQStack_6c);
      QVariant::QVariant(aQStack_5c,*(int *)(pQVar4 + -4));
      uStack_14 = 5;
      pQStack_80 = QString::fromAscii_helper("height",6);
      pQVar6 = aQStack_5c;
      uStack_14 = 6;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xffffff74,(QString *)&pQStack_80);
      QVariant::operator=(pQVar5,pQVar6);
      uStack_14 = 5;
      QString::~QString((QString *)&pQStack_80);
      uStack_14 = 2;
      QVariant::~QVariant(aQStack_5c);
      QVariant::QVariant(aQStack_4c,*(int *)pQVar4);
      uStack_14 = 7;
      pQStack_7c = QString::fromAscii_helper("bitsPerPixel",0xc);
      pQVar6 = aQStack_4c;
      uStack_14 = 8;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xffffff74,(QString *)&pQStack_7c);
      QVariant::operator=(pQVar5,pQVar6);
      uStack_14 = 7;
      QString::~QString((QString *)&pQStack_7c);
      uStack_14 = 2;
      QVariant::~QVariant(aQStack_4c);
      QVariant::QVariant(aQStack_3c,*(int *)(pQVar4 + 4));
      uStack_14 = 9;
      local_78 = QString::fromAscii_helper("refreshRate",0xb);
      pQVar6 = aQStack_3c;
      uStack_14 = 10;
      pQVar5 = (QVariant *)FUN_10003770(&stack0xffffff74,(QString *)&local_78);
      QVariant::operator=(pQVar5,pQVar6);
      uStack_14 = 9;
      QString::~QString((QString *)&local_78);
      uStack_14 = 2;
      QVariant::~QVariant(aQStack_3c);
      pQVar6 = FUN_10009130(aQStack_2c,&stack0xffffff74);
      uStack_14 = 0xb;
      FUN_10009840(this_00,pQVar6);
      uStack_14 = 2;
      QVariant::~QVariant(aQStack_2c);
      uStack_14 = 1;
      if (*(int *)this == 0) {
LAB_1000d148:
        iVar2 = *(int *)(this + 0xc);
        if (iVar2 != 0) {
          QString::~QString((QString *)(iVar2 + 0xc));
          QVariant::~QVariant((QVariant *)(iVar2 + 0x10));
          if (*(int *)(iVar2 + 4) != 0) {
            FUN_100041f0(*(int *)(iVar2 + 4));
          }
          if (*(int *)(iVar2 + 8) != 0) {
            FUN_100041f0(*(int *)(iVar2 + 8));
          }
          QMapDataBase::freeTree((QMapDataBase *)this,*(QMapNodeBase **)(this + 0xc),8);
        }
        QMapDataBase::freeData((QMapDataBase *)this);
        this_00 = local_c;
      }
      else if (*(int *)this != -1) {
        LOCK();
        iVar2 = *(int *)this;
        *(int *)this = iVar2 + -1;
        UNLOCK();
        if (iVar2 + -1 == 0) goto LAB_1000d148;
      }
      pQVar1 = pQVar4 + 8;
      pQVar4 = pQVar4 + 0x10;
    } while (pQVar1 != pQStack_70);
  }
  if (*(int *)unaff_EDI != 0) {
    if (*(int *)unaff_EDI == -1) {
      ExceptionList = pvStack_1c;
      return this_00;
    }
    LOCK();
    iVar2 = *(int *)unaff_EDI;
    *(int *)unaff_EDI = *(int *)unaff_EDI + -1;
    UNLOCK();
    if (iVar2 != 1) {
      ExceptionList = pvStack_1c;
      return this_00;
    }
  }
  QArrayData::deallocate(unaff_EDI,0x10,4);
  ExceptionList = pvStack_1c;
  return this_00;
}



void __thiscall FUN_1000d200(void *this,QString *param_1)

{
  QString::toUInt(param_1,(bool *)0x0,0x10);
                    // WARNING: Could not recover jumptable at 0x1000d21b. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)((int)this + 8) + 0x11c))();
  return;
}



void FUN_1000d230(undefined4 *param_1,QVariant *param_2)

{
  QVariant *this;
  undefined4 uVar1;
  int *unaff_FS_OFFSET;
  int local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10012c8b;
  local_c = *unaff_FS_OFFSET;
  *unaff_FS_OFFSET = (int)&local_c;
  this = (QVariant *)operator_new(0x10);
  local_4 = 0;
  if (this != (QVariant *)0x0) {
    uVar1 = QVariant::QVariant(this,param_2);
    *param_1 = uVar1;
    *unaff_FS_OFFSET = local_c;
    return;
  }
  *param_1 = 0;
  *unaff_FS_OFFSET = local_c;
  return;
}



void FUN_1000d2b0(QString *param_1,QString *param_2,int param_3)

{
  int iVar1;
  
  if (param_1 != param_2) {
    iVar1 = param_3 - (int)param_1;
    do {
      if (param_1 != (QString *)0x0) {
        QString::QString(param_1,param_1 + iVar1);
      }
      param_1 = param_1 + 4;
    } while (param_1 != param_2);
  }
  return;
}



void FUN_1000d2f0(undefined4 *param_1,undefined4 *param_2,undefined4 *param_3)

{
  QVariant *this;
  undefined4 uVar1;
  void *local_10;
  undefined1 *puStack_c;
  undefined1 local_8;
  undefined3 uStack_7;
  
  puStack_c = &LAB_10012cbb;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
  uStack_7 = 0;
  while (local_8 = 0, param_1 != param_2) {
    this = (QVariant *)operator_new(0x10);
    local_8 = 1;
    if (this == (QVariant *)0x0) {
      *param_1 = 0;
      param_1 = param_1 + 1;
      param_3 = param_3 + 1;
    }
    else {
      uVar1 = QVariant::QVariant(this,(QVariant *)*param_3);
      *param_1 = uVar1;
      param_1 = param_1 + 1;
      param_3 = param_3 + 1;
    }
  }
  ExceptionList = local_10;
  return;
}



void Catch_All_1000d36e(void)

{
  int iVar1;
  QVariant *this;
  int unaff_EBP;
  int iVar2;
  
  iVar2 = *(int *)(unaff_EBP + -0x14);
  iVar1 = *(int *)(unaff_EBP + 8);
  while (iVar2 != iVar1) {
    this = *(QVariant **)(iVar2 + -4);
    iVar2 = iVar2 + -4;
    if (this != (QVariant *)0x0) {
      QVariant::~QVariant(this);
      operator_delete(this);
    }
  }
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void FUN_1000d3c0(int param_1,int param_2)

{
  QVariant *this;
  
  if (param_1 != param_2) {
    do {
      this = *(QVariant **)(param_2 + -4);
      param_2 = param_2 + -4;
      if (this != (QVariant *)0x0) {
        QVariant::~QVariant(this);
        operator_delete(this);
      }
    } while (param_2 != param_1);
  }
  return;
}



undefined4 __thiscall FUN_1000d400(void *this,QString *param_1)

{
  int iVar1;
  QByteArray *this_00;
  char *pcVar2;
  undefined4 uVar3;
  void *unaff_EDI;
  void **ppvVar4;
  uint uStack_1c;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uStack_1c = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar4 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  uVar3 = (**(code **)(iVar1 + 0x88))(pcVar2,param_1,ppvVar4);
  local_10 = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&uStack_1c);
  ExceptionList = unaff_EDI;
  return uVar3;
}



void __thiscall FUN_1000d490(void *this,QString *param_1)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  char *pcVar3;
  void *unaff_ESI;
  void **ppvVar4;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar4 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0x84))(pcVar3,ppvVar4,uVar2);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_ESI;
  return;
}



void __thiscall FUN_1000d510(void *this,undefined4 param_1,QString *param_2)

{
  QTypedArrayData<> *pQVar1;
  int iVar2;
  QColor *this_00;
  bool bVar3;
  QString *pQVar4;
  QVariant *pQVar5;
  QVariant *pQVar6;
  QMutex *extraout_ECX;
  QMutex *this_01;
  void *this_02;
  void *pvVar7;
  QTypedArrayData<> *pQVar8;
  int unaff_ESI;
  QTypedArrayData<> *pQVar9;
  Data *this_03;
  undefined4 local_74;
  QTypedArrayData<> *pQStack_70;
  void *pvStack_6c;
  int iStack_58;
  undefined4 local_54;
  QMutex *local_50;
  void *local_4c;
  QVariant aQStack_48 [16];
  QVariant aQStack_38 [20];
  void *pvStack_24;
  undefined1 uStack_20;
  uint uStack_1c;
  QColor *pQStack_14;
  code *pcStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10012d8a;
  local_c = ExceptionList;
  pvStack_6c = (void *)(DAT_10022088 ^ (uint)&stack0xffffff98);
  ExceptionList = &local_c;
  this_01 = (QMutex *)((int)this + 0xc);
  local_54 = 0;
  local_50 = this_01;
  local_4c = this;
  if (this_01 != (QMutex *)0x0) {
    pQStack_70 = (QTypedArrayData<> *)0x1000d556;
    QMutex::lock(this_01);
    local_50 = (QMutex *)((uint)local_50 | 1);
    this_01 = extraout_ECX;
  }
  pQStack_70 = (QTypedArrayData<> *)0x1;
  local_4 = 0;
  local_74 = (QTypedArrayData<> *)CONCAT22((short)((uint)this_01 >> 0x10),10);
  bVar3 = QString::endsWith(param_2);
  if (bVar3) {
    pQVar4 = (QString *)QString::left(param_2,(int)&local_4c);
    pcStack_10 = (code *)CONCAT31(pcStack_10._1_3_,1);
    this_02 = (void *)0x1;
  }
  else {
    pQVar4 = (QString *)QString::QString((QString *)&local_50,param_2);
    local_c = (void *)0x2;
    this_02 = (void *)0x2;
  }
  QString::split(pQVar4,&stack0xffffffa0,10,0,1);
  uStack_1c = 4;
  pvVar7 = this_02;
  if (((uint)this_02 & 2) != 0) {
    pvVar7 = (void *)((uint)this_02 & 0xfffffffd);
    pvStack_6c = pvVar7;
    QString::~QString((QString *)&stack0xffffffa0);
  }
  uStack_1c = CONCAT31(uStack_1c._1_3_,5);
  if (((uint)pvVar7 & 1) != 0) {
    QString::~QString((QString *)&stack0xffffffa4);
  }
  if ((*(int *)pQStack_70 != 1) && (*(int *)pQStack_70 != 0)) {
    FUN_10009c10(&pQStack_70,*(int *)(pQStack_70 + 4));
  }
  pQVar9 = pQStack_70 + (*(int *)(pQStack_70 + 8) + 4) * 4;
  if ((*(int *)pQStack_70 != 1) && (*(int *)pQStack_70 != 0)) {
    FUN_10009c10(&pQStack_70,*(int *)(pQStack_70 + 4));
  }
  pQVar1 = pQStack_70 + (*(int *)(pQStack_70 + 0xc) + 4) * 4;
  pQVar8 = pQStack_70;
  if (pQVar9 != pQVar1) {
    iStack_58 = unaff_ESI + 0x10;
    do {
      pcStack_10 = shared_null_exref;
      uStack_1c = CONCAT31(uStack_1c._1_3_,6);
      QColor::operator_class_QVariant(pQStack_14);
      uStack_20 = 7;
      pQStack_70 = QString::fromAscii_helper("color",5);
      pQVar6 = (QVariant *)&iStack_58;
      uStack_20 = 8;
      pQVar5 = (QVariant *)FUN_10003770(&pQStack_14,(QString *)&pQStack_70);
      QVariant::operator=(pQVar5,pQVar6);
      uStack_20 = 7;
      QString::~QString((QString *)&pQStack_70);
      uStack_20 = 6;
      QVariant::~QVariant((QVariant *)&iStack_58);
      QVariant::QVariant(aQStack_48,(QString *)pQVar9);
      uStack_20 = 9;
      QString::fromAscii_helper((char *)&param_1_1001530c,4);
      pQVar6 = aQStack_48;
      uStack_20 = 10;
      pQVar5 = (QVariant *)FUN_10003770(&pQStack_14,(QString *)&stack0xffffff98);
      QVariant::operator=(pQVar5,pQVar6);
      uStack_20 = 9;
      QString::~QString((QString *)&stack0xffffff98);
      uStack_20 = 6;
      QVariant::~QVariant(aQStack_48);
      pQVar6 = FUN_10009130(aQStack_38,&pQStack_14);
      uStack_20 = 0xb;
      FUN_10009840(this_02,pQVar6);
      uStack_20 = 6;
      QVariant::~QVariant(aQStack_38);
      this_00 = pQStack_14;
      uStack_20 = 5;
      if (*(int *)pQStack_14 == 0) {
LAB_1000d78f:
        iVar2 = *(int *)(pQStack_14 + 0xc);
        if (iVar2 != 0) {
          QString::~QString((QString *)(iVar2 + 0xc));
          QVariant::~QVariant((QVariant *)(iVar2 + 0x10));
          if (*(int *)(iVar2 + 4) != 0) {
            FUN_100041f0(*(int *)(iVar2 + 4));
          }
          if (*(int *)(iVar2 + 8) != 0) {
            FUN_100041f0(*(int *)(iVar2 + 8));
          }
          QMapDataBase::freeTree((QMapDataBase *)this_00,*(QMapNodeBase **)(this_00 + 0xc),8);
        }
        QMapDataBase::freeData((QMapDataBase *)this_00);
      }
      else if (*(int *)pQStack_14 != -1) {
        LOCK();
        iVar2 = *(int *)pQStack_14;
        *(int *)pQStack_14 = iVar2 + -1;
        UNLOCK();
        if (iVar2 + -1 == 0) goto LAB_1000d78f;
      }
      pQVar9 = (QTypedArrayData<> *)((QString *)pQVar9 + 4);
      pQVar8 = local_74;
    } while (pQVar9 != pQVar1);
  }
  uStack_1c = uStack_1c & 0xffffff00;
  if (*(int *)pQVar8 != 0) {
    if (*(int *)pQVar8 == -1) goto LAB_1000d83e;
    LOCK();
    iVar2 = *(int *)pQVar8;
    *(int *)pQVar8 = *(int *)pQVar8 + -1;
    UNLOCK();
    pQVar8 = pQStack_70;
    if (iVar2 != 1) goto LAB_1000d83e;
  }
  iVar2 = *(int *)((Data *)pQVar8 + 8);
  this_03 = (Data *)pQVar8 + (*(int *)((Data *)pQVar8 + 0xc) + 4) * 4;
  while ((Data *)pQVar8 + (iVar2 + 4) * 4 != this_03) {
    this_03 = this_03 + -4;
    QString::~QString((QString *)this_03);
  }
  QListData::dispose((Data *)pQVar8);
LAB_1000d83e:
  QMutexLocker::unlock((QMutexLocker *)&stack0xffffff98);
  ExceptionList = pvStack_24;
  return;
}



QString * __thiscall FUN_1000d860(void *this,QString *param_1,undefined4 param_2,QString *param_3)

{
  QByteArray *this_00;
  QByteArray *this_01;
  char *pcVar1;
  char *pcVar2;
  int iVar3;
  int iVar4;
  QString *pQVar5;
  void *unaff_EBP;
  undefined4 uVar6;
  int iVar7;
  QByteArray **ppQVar8;
  undefined1 *puVar9;
  undefined1 *puVar10;
  uint uStack_2c;
  undefined1 local_14 [4];
  QString *local_10;
  void *local_c;
  undefined1 *local_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  local_8 = &LAB_10012de5;
  local_c = ExceptionList;
  uStack_2c = DAT_10022088 ^ (uint)&stack0xffffffd8;
  ExceptionList = &local_c;
  local_10 = (QString *)0x0;
  puVar10 = local_14;
  this_00 = (QByteArray *)QString::toLatin1(param_3);
  puVar9 = &stack0xffffffe4;
  local_8 = (undefined1 *)0x1;
  this_01 = (QByteArray *)QString::toLatin1(param_1);
  local_c = (void *)CONCAT31(local_c._1_3_,2);
  iVar3 = **(int **)((int)this + 8);
  pcVar1 = QByteArray::constData(this_00);
  ppQVar8 = &this_1001519c;
  pcVar2 = QByteArray::constData(this_01);
  iVar3 = (**(code **)(iVar3 + 0xa4))(pcVar2,ppQVar8,pcVar1,puVar9,puVar10);
  QByteArray::~QByteArray((QByteArray *)&uStack_2c);
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffd8);
  if (iVar3 == 0) {
    QString::QString(local_10);
    pQVar5 = local_10;
  }
  else {
    iVar4 = (**(code **)(**(int **)((int)this + 8) + 0xb4))(iVar3);
    QByteArray::QByteArray((QByteArray *)&local_c,iVar4,'\0');
    uVar6 = *(undefined4 *)((int)local_c + 4);
    iVar4 = **(int **)((int)this + 8);
    iVar7 = iVar3;
    pcVar1 = QByteArray::data((QByteArray *)&local_c);
    (**(code **)(iVar4 + 0x9c))(pcVar1,uVar6,iVar7);
    (**(code **)(**(int **)((int)this + 8) + 0xa8))(iVar3);
    pQVar5 = local_10;
    QString::fromUtf8((QByteArray *)local_10);
    QByteArray::~QByteArray((QByteArray *)&local_8);
  }
  ExceptionList = unaff_EBP;
  return pQVar5;
}



void __thiscall FUN_1000d9b0(void *this,int param_1,uint param_2,undefined4 param_3)

{
  int iVar1;
  QArrayData *pQVar2;
  bool bVar3;
  QArrayData *pQVar4;
  QArrayData *pQVar5;
  int iVar6;
  int iVar7;
  undefined4 *puVar8;
  undefined4 *puVar9;
  QArrayData *pQVar10;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_10012e00;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
                    // WARNING: Load size is inaccurate
  pQVar2 = *this;
  if ((*(int *)pQVar2 == 1) || (*(int *)pQVar2 == 0)) {
    bVar3 = false;
  }
  else {
    bVar3 = true;
  }
  pQVar5 = (QArrayData *)shared_null_exref;
  if (param_2 != 0) {
    if ((param_2 != (*(uint *)(pQVar2 + 8) & 0x7fffffff)) || (bVar3)) {
      local_8 = 0;
      pQVar5 = QArrayData::allocate(0x8c,4,param_2,param_3);
      if (pQVar5 == (QArrayData *)0x0) {
        qBadAlloc();
      }
      *(int *)(pQVar5 + 4) = param_1;
                    // WARNING: Load size is inaccurate
      iVar1 = *this;
      puVar8 = (undefined4 *)(*(int *)(iVar1 + 0xc) + iVar1);
      if (*(int *)(iVar1 + 4) < param_1) {
        iVar6 = *(int *)(iVar1 + 4) * 0x8c + *(int *)(iVar1 + 0xc);
      }
      else {
        iVar6 = *(int *)(iVar1 + 0xc) + param_1 * 0x8c;
      }
      pQVar2 = pQVar5 + *(int *)(pQVar5 + 0xc);
      while (pQVar4 = pQVar2, puVar8 != (undefined4 *)(iVar6 + iVar1)) {
        pQVar2 = pQVar4 + 0x8c;
        if (pQVar4 != (QArrayData *)0x0) {
          puVar9 = puVar8;
          pQVar10 = pQVar4;
          for (iVar7 = 0x23; iVar7 != 0; iVar7 = iVar7 + -1) {
            *(undefined4 *)pQVar10 = *puVar9;
            puVar9 = puVar9 + 1;
            pQVar10 = pQVar10 + 4;
          }
          puVar8 = puVar8 + 0x23;
        }
      }
                    // WARNING: Load size is inaccurate
      if (*(int *)(*this + 4) < param_1) {
        FUN_10009b20(pQVar4,pQVar5 + *(int *)(pQVar5 + 4) * 0x8c + *(int *)(pQVar5 + 0xc));
      }
                    // WARNING: Load size is inaccurate
      *(uint *)(pQVar5 + 8) =
           (*(uint *)(*this + 8) ^ *(uint *)(pQVar5 + 8)) & 0x7fffffff ^ *(uint *)(*this + 8);
    }
    else {
      if (*(int *)(pQVar2 + 4) < param_1) {
        FUN_10009b20(pQVar2 + *(int *)(pQVar2 + 4) * 0x8c + *(int *)(pQVar2 + 0xc),
                     pQVar2 + param_1 * 0x8c + *(int *)(pQVar2 + 0xc));
      }
      *(int *)(pQVar2 + 4) = param_1;
      pQVar5 = pQVar2;
    }
  }
                    // WARNING: Load size is inaccurate
  pQVar2 = *this;
  if (pQVar2 == pQVar5) {
    ExceptionList = local_10;
    return;
  }
  if (*(int *)pQVar2 != 0) {
    if (*(int *)pQVar2 == -1) goto LAB_1000db44;
    LOCK();
    iVar1 = *(int *)pQVar2;
    *(int *)pQVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) goto LAB_1000db44;
  }
                    // WARNING: Load size is inaccurate
  QArrayData::deallocate(*this,0x8c,4);
LAB_1000db44:
  *(QArrayData **)this = pQVar5;
  ExceptionList = local_10;
  return;
}



void Catch_All_1000da83(void)

{
  FUN_10009aa0((QArrayData *)0x0);
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void __thiscall FUN_1000db60(void *this,int param_1,uint param_2,undefined4 param_3)

{
  int iVar1;
  QArrayData *pQVar2;
  bool bVar3;
  QArrayData *pQVar4;
  QArrayData *pQVar5;
  int iVar6;
  int iVar7;
  undefined4 *puVar8;
  undefined4 *puVar9;
  QArrayData *pQVar10;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_10012e20;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
                    // WARNING: Load size is inaccurate
  pQVar2 = *this;
  if ((*(int *)pQVar2 == 1) || (*(int *)pQVar2 == 0)) {
    bVar3 = false;
  }
  else {
    bVar3 = true;
  }
  pQVar5 = (QArrayData *)shared_null_exref;
  if (param_2 != 0) {
    if ((param_2 != (*(uint *)(pQVar2 + 8) & 0x7fffffff)) || (bVar3)) {
      local_8 = 0;
      pQVar5 = QArrayData::allocate(0x84,4,param_2,param_3);
      if (pQVar5 == (QArrayData *)0x0) {
        qBadAlloc();
      }
      *(int *)(pQVar5 + 4) = param_1;
                    // WARNING: Load size is inaccurate
      iVar1 = *this;
      puVar8 = (undefined4 *)(*(int *)(iVar1 + 0xc) + iVar1);
      if (*(int *)(iVar1 + 4) < param_1) {
        iVar6 = *(int *)(iVar1 + 4) * 0x84 + *(int *)(iVar1 + 0xc);
      }
      else {
        iVar6 = *(int *)(iVar1 + 0xc) + param_1 * 0x84;
      }
      pQVar2 = pQVar5 + *(int *)(pQVar5 + 0xc);
      while (pQVar4 = pQVar2, puVar8 != (undefined4 *)(iVar6 + iVar1)) {
        pQVar2 = pQVar4 + 0x84;
        if (pQVar4 != (QArrayData *)0x0) {
          puVar9 = puVar8;
          pQVar10 = pQVar4;
          for (iVar7 = 0x21; iVar7 != 0; iVar7 = iVar7 + -1) {
            *(undefined4 *)pQVar10 = *puVar9;
            puVar9 = puVar9 + 1;
            pQVar10 = pQVar10 + 4;
          }
          puVar8 = puVar8 + 0x21;
        }
      }
                    // WARNING: Load size is inaccurate
      if (*(int *)(*this + 4) < param_1) {
        FUN_10009b60((int)pQVar4,
                     (int)(pQVar5 + *(int *)(pQVar5 + 4) * 0x84 + *(int *)(pQVar5 + 0xc)));
      }
                    // WARNING: Load size is inaccurate
      *(uint *)(pQVar5 + 8) =
           (*(uint *)(*this + 8) ^ *(uint *)(pQVar5 + 8)) & 0x7fffffff ^ *(uint *)(*this + 8);
    }
    else {
      if (*(int *)(pQVar2 + 4) < param_1) {
        FUN_10009b60((int)(pQVar2 + *(int *)(pQVar2 + 4) * 0x84 + *(int *)(pQVar2 + 0xc)),
                     (int)(pQVar2 + param_1 * 0x84 + *(int *)(pQVar2 + 0xc)));
      }
      *(int *)(pQVar2 + 4) = param_1;
      pQVar5 = pQVar2;
    }
  }
                    // WARNING: Load size is inaccurate
  pQVar2 = *this;
  if (pQVar2 == pQVar5) {
    ExceptionList = local_10;
    return;
  }
  if (*(int *)pQVar2 != 0) {
    if (*(int *)pQVar2 == -1) goto LAB_1000dcf4;
    LOCK();
    iVar1 = *(int *)pQVar2;
    *(int *)pQVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) goto LAB_1000dcf4;
  }
                    // WARNING: Load size is inaccurate
  QArrayData::deallocate(*this,0x84,4);
LAB_1000dcf4:
  *(QArrayData **)this = pQVar5;
  ExceptionList = local_10;
  return;
}



void Catch_All_1000dc33(void)

{
  FUN_10009ac0((QArrayData *)0x0);
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void __thiscall FUN_1000dd10(void *this,int param_1,uint param_2,undefined4 param_3)

{
  int iVar1;
  QArrayData *pQVar2;
  int iVar3;
  bool bVar5;
  QArrayData *pQVar6;
  QArrayData *pQVar7;
  int iVar8;
  undefined4 *puVar9;
  undefined4 *puVar10;
  QArrayData *pQVar11;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  int iVar4;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_10012e40;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
                    // WARNING: Load size is inaccurate
  pQVar2 = *this;
  if ((*(int *)pQVar2 == 1) || (*(int *)pQVar2 == 0)) {
    bVar5 = false;
  }
  else {
    bVar5 = true;
  }
  pQVar7 = (QArrayData *)shared_null_exref;
  if (param_2 != 0) {
    if ((param_2 != (*(uint *)(pQVar2 + 8) & 0x7fffffff)) || (bVar5)) {
      local_8 = 0;
      pQVar7 = QArrayData::allocate(0x20c,4,param_2,param_3);
      if (pQVar7 == (QArrayData *)0x0) {
        qBadAlloc();
      }
      *(int *)(pQVar7 + 4) = param_1;
                    // WARNING: Load size is inaccurate
      iVar1 = *this;
      puVar9 = (undefined4 *)(*(int *)(iVar1 + 0xc) + iVar1);
      iVar4 = param_1;
      if (*(int *)(iVar1 + 4) < param_1) {
        iVar4 = *(int *)(iVar1 + 4);
      }
      iVar3 = *(int *)(iVar1 + 0xc);
      pQVar2 = pQVar7 + *(int *)(pQVar7 + 0xc);
      while (pQVar6 = pQVar2, puVar9 != (undefined4 *)(iVar4 * 0x20c + iVar3 + iVar1)) {
        pQVar2 = pQVar6 + 0x20c;
        if (pQVar6 != (QArrayData *)0x0) {
          puVar10 = puVar9;
          pQVar11 = pQVar6;
          for (iVar8 = 0x83; iVar8 != 0; iVar8 = iVar8 + -1) {
            *(undefined4 *)pQVar11 = *puVar10;
            puVar10 = puVar10 + 1;
            pQVar11 = pQVar11 + 4;
          }
          puVar9 = puVar9 + 0x83;
        }
      }
                    // WARNING: Load size is inaccurate
      if (*(int *)(*this + 4) < param_1) {
        FUN_10009b90(pQVar6,pQVar7 + *(int *)(pQVar7 + 4) * 0x20c + *(int *)(pQVar7 + 0xc));
      }
                    // WARNING: Load size is inaccurate
      *(uint *)(pQVar7 + 8) =
           (*(uint *)(*this + 8) ^ *(uint *)(pQVar7 + 8)) & 0x7fffffff ^ *(uint *)(*this + 8);
    }
    else {
      if (*(int *)(pQVar2 + 4) < param_1) {
        FUN_10009b90(pQVar2 + *(int *)(pQVar2 + 4) * 0x20c + *(int *)(pQVar2 + 0xc),
                     pQVar2 + param_1 * 0x20c + *(int *)(pQVar2 + 0xc));
      }
      *(int *)(pQVar2 + 4) = param_1;
      pQVar7 = pQVar2;
    }
  }
                    // WARNING: Load size is inaccurate
  pQVar2 = *this;
  if (pQVar2 == pQVar7) {
    ExceptionList = local_10;
    return;
  }
  if (*(int *)pQVar2 != 0) {
    if (*(int *)pQVar2 == -1) goto LAB_1000dea4;
    LOCK();
    iVar1 = *(int *)pQVar2;
    *(int *)pQVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) goto LAB_1000dea4;
  }
                    // WARNING: Load size is inaccurate
  QArrayData::deallocate(*this,0x20c,4);
LAB_1000dea4:
  *(QArrayData **)this = pQVar7;
  ExceptionList = local_10;
  return;
}



void Catch_All_1000dde0(void)

{
  FUN_10009ae0((QArrayData *)0x0);
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void __thiscall FUN_1000ded0(void *this,int param_1,uint param_2,undefined4 param_3)

{
  int iVar1;
  QArrayData *pQVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  undefined4 uVar5;
  undefined4 uVar6;
  bool bVar7;
  QArrayData *pQVar8;
  QArrayData *pQVar9;
  undefined4 *puVar10;
  int iVar11;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_10012e60;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
                    // WARNING: Load size is inaccurate
  pQVar2 = *this;
  if ((*(int *)pQVar2 == 1) || (*(int *)pQVar2 == 0)) {
    bVar7 = false;
  }
  else {
    bVar7 = true;
  }
  pQVar9 = (QArrayData *)shared_null_exref;
  if (param_2 != 0) {
    if ((param_2 != (*(uint *)(pQVar2 + 8) & 0x7fffffff)) || (bVar7)) {
      local_8 = 0;
      pQVar9 = QArrayData::allocate(0x10,4,param_2,param_3);
      if (pQVar9 == (QArrayData *)0x0) {
        qBadAlloc();
      }
      *(int *)(pQVar9 + 4) = param_1;
                    // WARNING: Load size is inaccurate
      iVar1 = *this;
      puVar10 = (undefined4 *)(*(int *)(iVar1 + 0xc) + iVar1);
      if (*(int *)(iVar1 + 4) < param_1) {
        iVar11 = *(int *)(iVar1 + 4) * 0x10 + *(int *)(iVar1 + 0xc);
      }
      else {
        iVar11 = *(int *)(iVar1 + 0xc) + param_1 * 0x10;
      }
      pQVar2 = pQVar9 + *(int *)(pQVar9 + 0xc);
      while (pQVar8 = pQVar2, puVar10 != (undefined4 *)(iVar11 + iVar1)) {
        pQVar2 = pQVar8 + 0x10;
        if (pQVar8 != (QArrayData *)0x0) {
          uVar3 = *puVar10;
          uVar4 = puVar10[1];
          uVar5 = puVar10[2];
          uVar6 = puVar10[3];
          puVar10 = puVar10 + 4;
          *(undefined4 *)pQVar8 = uVar3;
          *(undefined4 *)(pQVar8 + 4) = uVar4;
          *(undefined4 *)(pQVar8 + 8) = uVar5;
          *(undefined4 *)(pQVar8 + 0xc) = uVar6;
        }
      }
                    // WARNING: Load size is inaccurate
      if (*(int *)(*this + 4) < param_1) {
        FUN_10009bd0((undefined4 *)pQVar8,
                     (undefined4 *)(pQVar9 + *(int *)(pQVar9 + 4) * 0x10 + *(int *)(pQVar9 + 0xc)));
      }
                    // WARNING: Load size is inaccurate
      *(uint *)(pQVar9 + 8) =
           (*(uint *)(*this + 8) ^ *(uint *)(pQVar9 + 8)) & 0x7fffffff ^ *(uint *)(*this + 8);
    }
    else {
      if (*(int *)(pQVar2 + 4) < param_1) {
        FUN_10009bd0((undefined4 *)(pQVar2 + *(int *)(pQVar2 + 4) * 0x10 + *(int *)(pQVar2 + 0xc)),
                     (undefined4 *)(pQVar2 + param_1 * 0x10 + *(int *)(pQVar2 + 0xc)));
      }
      *(int *)(pQVar2 + 4) = param_1;
      pQVar9 = pQVar2;
    }
  }
                    // WARNING: Load size is inaccurate
  pQVar2 = *this;
  if (pQVar2 == pQVar9) {
    ExceptionList = local_10;
    return;
  }
  if (*(int *)pQVar2 != 0) {
    if (*(int *)pQVar2 == -1) goto LAB_1000e040;
    LOCK();
    iVar1 = *(int *)pQVar2;
    *(int *)pQVar2 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) goto LAB_1000e040;
  }
                    // WARNING: Load size is inaccurate
  QArrayData::deallocate(*this,0x10,4);
LAB_1000e040:
  *(QArrayData **)this = pQVar9;
  ExceptionList = local_10;
  return;
}



void Catch_All_1000df98(void)

{
  FUN_10009b00((QArrayData *)0x0);
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void __fastcall FUN_1000e060(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000e065. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x100))();
  return;
}



undefined1 __thiscall FUN_1000e070(void *this,QString *param_1)

{
  int iVar1;
  undefined1 uVar2;
  uint uVar3;
  QByteArray *this_00;
  char *pcVar4;
  void *unaff_EBX;
  void **ppvVar5;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_100124c9;
  local_c = ExceptionList;
  uVar3 = DAT_10022088 ^ (uint)&stack0xffffffe4;
  ExceptionList = &local_c;
  ppvVar5 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar4 = QByteArray::constData(this_00);
  uVar2 = (**(code **)(iVar1 + 0x110))(pcVar4,ppvVar5,uVar3);
  local_c = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe8);
  ExceptionList = unaff_EBX;
  return uVar2;
}



uint __thiscall FUN_1000e100(void *this,uint param_1)

{
  int iVar1;
  
  iVar1 = (**(code **)(**(int **)((int)this + 8) + 0x120))(0);
  QString::number(param_1,iVar1);
  return param_1;
}



uint __thiscall FUN_1000e130(void *this,uint param_1)

{
  int iVar1;
  
  iVar1 = (**(code **)(**(int **)((int)this + 8) + 0x124))(0);
  QString::number(param_1,iVar1);
  return param_1;
}



uint __thiscall FUN_1000e160(void *this,uint param_1)

{
  int iVar1;
  
  iVar1 = (**(code **)(**(int **)((int)this + 8) + 0x128))(0);
  QString::number(param_1,iVar1);
  return param_1;
}



uint __thiscall FUN_1000e190(void *this,uint param_1)

{
  int iVar1;
  
  iVar1 = (**(code **)(**(int **)((int)this + 8) + 300))(0);
  QString::number(param_1,iVar1);
  return param_1;
}



void __fastcall FUN_1000e1c0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000e1c5. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x68))();
  return;
}



uint __thiscall FUN_1000e1d0(void *this,uint param_1)

{
  int iVar1;
  
  iVar1 = (**(code **)(**(int **)((int)this + 8) + 0x130))(0);
  QString::number(param_1,iVar1);
  return param_1;
}



uint __thiscall FUN_1000e200(void *this,uint param_1)

{
  int iVar1;
  
  iVar1 = (**(code **)(**(int **)((int)this + 8) + 0x134))(0);
  QString::number(param_1,iVar1);
  return param_1;
}



void __thiscall FUN_1000e230(void *this,QString *param_1)

{
  int iVar1;
  QByteArray *this_00;
  char *pcVar2;
  void *unaff_EDI;
  void **ppvVar3;
  uint uStack_1c;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uStack_1c = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar3 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0xe0))(pcVar2,param_1,ppvVar3);
  local_10 = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&uStack_1c);
  ExceptionList = unaff_EDI;
  return;
}



void __thiscall FUN_1000e2b0(void *this,QString *param_1)

{
  int iVar1;
  QByteArray *this_00;
  char *pcVar2;
  void *unaff_EDI;
  void **ppvVar3;
  uint uStack_1c;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uStack_1c = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar3 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0xd8))(pcVar2,param_1,ppvVar3);
  local_10 = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&uStack_1c);
  ExceptionList = unaff_EDI;
  return;
}



void __thiscall FUN_1000e340(void *this,QString *param_1)

{
  int iVar1;
  QByteArray *this_00;
  char *pcVar2;
  void *unaff_EDI;
  void **ppvVar3;
  uint uStack_1c;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uStack_1c = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar3 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0xdc))(pcVar2,param_1,ppvVar3);
  local_10 = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&uStack_1c);
  ExceptionList = unaff_EDI;
  return;
}



void __thiscall FUN_1000e3c0(void *this,undefined4 param_1,QString *param_2)

{
  int iVar1;
  uint uVar2;
  QByteArray *this_00;
  QByteArray *this_01;
  char *pcVar3;
  char *pcVar4;
  void *unaff_ESI;
  QString *unaff_retaddr;
  undefined4 *puVar5;
  void **ppvVar6;
  void *local_10;
  void *local_c;
  undefined1 *local_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  local_8 = &LAB_100126f2;
  local_c = ExceptionList;
  uVar2 = DAT_10022088 ^ (uint)&stack0xffffffe0;
  ExceptionList = &local_c;
  ppvVar6 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_2);
  puVar5 = &param_1;
  local_8 = (undefined1 *)0x0;
  this_01 = (QByteArray *)QString::toLatin1(unaff_retaddr);
  local_c = (void *)CONCAT31(local_c._1_3_,1);
  iVar1 = **(int **)((int)this + 8);
  pcVar3 = QByteArray::constData(this_00);
  pcVar4 = QByteArray::constData(this_01);
  (**(code **)(iVar1 + 0xe8))(pcVar4,pcVar3,puVar5,ppvVar6,uVar2);
  QByteArray::~QByteArray((QByteArray *)&local_8);
  QByteArray::~QByteArray((QByteArray *)&stack0xffffffe0);
  ExceptionList = unaff_ESI;
  return;
}



void __thiscall FUN_1000e470(void *this,QString *param_1)

{
  int iVar1;
  QByteArray *this_00;
  char *pcVar2;
  undefined4 *puVar3;
  undefined4 *puVar4;
  uint uStack_28;
  undefined4 local_1c;
  void *pvStack_18;
  undefined4 uStack_14;
  undefined4 uStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012e89;
  local_c = ExceptionList;
  uStack_28 = DAT_10022088 ^ (uint)&stack0xffffffdc;
  ExceptionList = &local_c;
  puVar4 = &local_1c;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  uStack_14 = *(undefined4 *)(param_1 + 8);
  pvStack_18 = *(void **)(param_1 + 4);
  local_1c = *(undefined4 *)param_1;
  iVar1 = **(int **)((int)this + 8);
  puVar3 = &local_1c;
  pcVar2 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0xe4))(pcVar2,puVar3,puVar4);
  uStack_10 = 0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&uStack_28);
  ExceptionList = pvStack_18;
  return;
}



void __thiscall FUN_1000e520(void *this,QString *param_1)

{
  int iVar1;
  QByteArray *this_00;
  char *pcVar2;
  void *unaff_EDI;
  void **ppvVar3;
  uint uStack_1c;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10012ce9;
  local_c = ExceptionList;
  uStack_1c = DAT_10022088 ^ (uint)&stack0xffffffe8;
  ExceptionList = &local_c;
  ppvVar3 = &local_10;
  local_10 = this;
  this_00 = (QByteArray *)QString::toLatin1(param_1);
  puStack_8 = (undefined1 *)0x0;
  iVar1 = **(int **)((int)this + 8);
  pcVar2 = QByteArray::constData(this_00);
  (**(code **)(iVar1 + 0x34))(pcVar2,param_1,ppvVar3);
  local_10 = (void *)0xffffffff;
  QByteArray::~QByteArray((QByteArray *)&uStack_1c);
  ExceptionList = unaff_EDI;
  return;
}



void __fastcall FUN_1000e5a0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000e5a5. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x108))();
  return;
}



void __fastcall FUN_1000e5b0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000e5b5. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x104))();
  return;
}



void __thiscall FUN_1000e5c0(void *this,undefined4 param_1,undefined4 param_2)

{
  (**(code **)(**(int **)((int)this + 8) + 0x94))(param_1,param_2);
  return;
}



void __fastcall FUN_1000e5e0(void *param_1)

{
  undefined4 *puVar1;
  int iVar2;
  Data *pDVar3;
  code *pcVar4;
  QMutex *local_18;
  code *pcStack_14;
  void *local_c;
  undefined1 *puStack_8;
  int local_4;
  
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10012ec1;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  local_18 = (QMutex *)((int)param_1 + 0xc);
  if (local_18 != (QMutex *)0x0) {
    QMutex::lock(local_18);
    local_18 = (QMutex *)((uint)local_18 | 1);
  }
  puVar1 = (undefined4 *)((int)param_1 + 0x10);
  local_4 = 0;
  FUN_1000f4d0(param_1,puVar1);
  pcVar4 = shared_null_exref;
  pDVar3 = (Data *)*puVar1;
  *puVar1 = shared_null_exref;
  local_4._0_1_ = 1;
  pcStack_14 = pcVar4;
  if (*(int *)pDVar3 == 0) {
LAB_1000e65d:
    FUN_10009a40(pDVar3);
  }
  else if (*(int *)pDVar3 != -1) {
    LOCK();
    iVar2 = *(int *)pDVar3;
    *(int *)pDVar3 = iVar2 + -1;
    UNLOCK();
    if (iVar2 + -1 == 0) goto LAB_1000e65d;
  }
  local_4 = (uint)local_4._1_3_ << 8;
  if (*(int *)pcVar4 != 0) {
    if (*(int *)pcVar4 == -1) goto LAB_1000e68d;
    LOCK();
    iVar2 = *(int *)pcVar4;
    *(int *)pcVar4 = *(int *)pcVar4 + -1;
    UNLOCK();
    if (iVar2 != 1) goto LAB_1000e68d;
  }
  FUN_10009a40((Data *)pcVar4);
LAB_1000e68d:
  QMutexLocker::unlock((QMutexLocker *)&local_18);
  ExceptionList = local_c;
  return;
}



void __fastcall FUN_1000e6b0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000e6b5. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x90))();
  return;
}



void __fastcall FUN_1000e6c0(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1000e6c5. Too many branches
                    // WARNING: Treating indirect jump as call
  (**(code **)(**(int **)(param_1 + 8) + 0x24))();
  return;
}



void * __thiscall FUN_1000e6d0(void *this,undefined4 param_1,undefined4 param_2)

{
  QQuickImageProvider::QQuickImageProvider((QQuickImageProvider *)this,param_1,param_2);
  *(undefined ***)this = BlackMesaQuickImageProvider::vftable;
  *(undefined4 *)((int)this + 8) = 0;
  return this;
}



void __fastcall FUN_1000e700(QQuickImageProvider *param_1)

{
  QMessageLogger *this;
  QDebug *this_00;
  QMessageLogger local_20 [16];
  void *pvStack_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  puStack_8 = &this_10012ef2;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  *(undefined ***)param_1 = BlackMesaQuickImageProvider::vftable;
  local_4 = 0;
  this = (QMessageLogger *)QMessageLogger::QMessageLogger(local_20,(char *)0x0,0,(char *)0x0);
  this_00 = (QDebug *)QMessageLogger::debug(this);
  puStack_8._0_1_ = 1;
  QDebug::operator<<(this_00,"Attached QuickImageProvider Types Are Deleted With QML Engine");
  puStack_8 = (undefined1 *)((uint)puStack_8._1_3_ << 8);
  QDebug::~QDebug((QDebug *)&stack0xffffffd4);
  puStack_8 = (undefined1 *)0xffffffff;
  QQuickImageProvider::~QQuickImageProvider(param_1);
  ExceptionList = pvStack_10;
  return;
}



void * __thiscall FUN_1000e7a0(void *this,byte param_1)

{
  FUN_1000e700((QQuickImageProvider *)this);
  if ((param_1 & 1) != 0) {
    operator_delete(this);
  }
  return this;
}



QImage * __thiscall
FUN_1000e7c0(void *param_1,QImage *param_2,QTypedArrayData<> *param_3,QByteArray param_4,
            undefined4 param_5,int *param_6)

{
  QTypedArrayData<> *pQVar1;
  bool bVar2;
  bool bVar3;
  int iVar4;
  int *piVar5;
  QByteArray *pQVar6;
  char *pcVar7;
  int iVar8;
  char *pcVar9;
  size_t _Size;
  uchar *_Dst;
  uint *puVar10;
  QByteArray **ppQVar11;
  QImage **ppQVar12;
  int iVar13;
  undefined4 uVar14;
  QTypedArrayData<> **ppQVar15;
  uint local_30;
  QTypedArrayData<> *pQStack_2c;
  QTypedArrayData<> *pQStack_28;
  QTypedArrayData<> *pQStack_24;
  int iStack_20;
  QImage aQStack_1c [4];
  QByteArray aQStack_18 [4];
  QImage aQStack_14 [4];
  QImage aQStack_10 [4];
  void *local_c;
  undefined1 uStack_8;
  undefined3 uStack_7;
  int iStack_4;
  
  iStack_4 = 0xffffffff;
  uStack_8 = 0xe5;
  uStack_7 = 0x10012f;
  local_c = ExceptionList;
  ExceptionList = &local_c;
  if (*(int *)((int)param_1 + 8) == 0) {
    QImage::QImage(param_2);
    ExceptionList = local_c;
    return param_2;
  }
  iVar4 = FUN_100042b0(*(int *)((int)param_1 + 8));
  if (iVar4 == 0) {
    QImage::QImage(param_2);
    ExceptionList = local_c;
    return param_2;
  }
  piVar5 = (int *)FUN_100042b0(*(int *)((int)param_1 + 8));
  QString::QString((QString *)&local_30);
  iStack_4 = 1;
  pQStack_28 = QString::fromAscii_helper((char *)&param_1_10015490,4);
  pQVar1 = param_3;
  iStack_4._0_1_ = 2;
  bVar2 = QString::endsWith((QString *)param_3,(QString *)&pQStack_28,0);
  iStack_4 = CONCAT31(iStack_4._1_3_,1);
  QString::~QString((QString *)&pQStack_28);
  if (bVar2) {
    QString::operator=((QString *)&local_30,(char *)&this_10015498);
  }
  param_3 = QString::fromAscii_helper((char *)&param_1_1001549c,4);
  iStack_4._0_1_ = 3;
  bVar2 = QString::endsWith((QString *)pQVar1,(QString *)&param_3,0);
  iStack_4 = CONCAT31(iStack_4._1_3_,1);
  QString::~QString((QString *)&param_3);
  if (bVar2) {
    QString::operator=((QString *)&local_30,"JPG");
  }
  if (*(int *)(local_30 + 4) != 0) {
    ppQVar15 = &pQStack_24;
    pQVar6 = (QByteArray *)QString::toLatin1((QString *)pQVar1);
    iVar4 = *piVar5;
    ppQVar12 = &param_1_10015194;
    ppQVar11 = &this_1001519c;
    uStack_8 = 4;
    pcVar7 = QByteArray::constData(pQVar6);
    iVar4 = (**(code **)(iVar4 + 0xa4))(pcVar7,ppQVar11,ppQVar12,ppQVar15);
    iStack_4._0_1_ = 1;
    QByteArray::~QByteArray((QByteArray *)&pQStack_24);
    if (iVar4 == 0) {
      QImage::QImage(param_2);
    }
    else {
      iVar8 = (**(code **)(*piVar5 + 0xb4))(iVar4);
      QByteArray::QByteArray((QByteArray *)&param_2);
      uStack_8 = 5;
      QByteArray::resize((QByteArray *)&param_2,iVar8);
      iVar8 = *piVar5;
      uVar14 = *(undefined4 *)(param_2 + 4);
      iVar13 = iVar4;
      pcVar7 = QByteArray::data((QByteArray *)&param_2);
      (**(code **)(iVar8 + 0x9c))(pcVar7,uVar14,iVar13);
      (**(code **)(*piVar5 + 0xa8))(iVar4);
      QImage::QImage((QImage *)&local_c);
      param_4 = (QByteArray)0x6;
      pQVar6 = (QByteArray *)QString::toLatin1((QString *)&iStack_20);
      param_3 = (QTypedArrayData<> *)CONCAT31(param_3._1_3_,7);
      pcVar7 = QByteArray::constData(pQVar6);
      QImage::loadFromData(aQStack_10,(QByteArray *)&param_6,pcVar7);
      param_3 = (QTypedArrayData<> *)CONCAT31(param_3._1_3_,6);
      QByteArray::~QByteArray(aQStack_18);
      piVar5 = (int *)QImage::size(aQStack_10);
      *param_6 = *piVar5;
      param_6[1] = piVar5[1];
      piVar5 = (int *)QImage::size(aQStack_14);
      pQVar1 = param_3;
      if (((*piVar5 != *param_6) || (piVar5[1] != param_6[1])) &&
         ((-1 < *param_6 && (-1 < param_6[1])))) {
        QImage::scaled((QImage *)aQStack_18,(QSize *)param_3,(AspectRatioMode)param_6,0);
        iStack_4._0_1_ = 5;
        QImage::~QImage(aQStack_1c);
        iStack_4._0_1_ = 1;
        QByteArray::~QByteArray((QByteArray *)&param_3);
        iStack_4 = (uint)iStack_4._1_3_ << 8;
        QString::~QString((QString *)&local_30);
        ExceptionList = local_c;
        return (QImage *)pQVar1;
      }
      QImage::QImage((QImage *)param_3,(QImage *)aQStack_18);
      local_30 = 1;
      QImage::~QImage((QImage *)aQStack_18);
      QByteArray::~QByteArray(&param_4);
    }
    goto LAB_1000ee5a;
  }
  pQStack_2c = QString::fromAscii_helper((char *)&param_1_100154a8,4);
  iStack_4 = CONCAT31(iStack_4._1_3_,8);
  bVar2 = false;
  bVar3 = QString::endsWith((QString *)pQVar1,(QString *)&pQStack_2c,0);
  if (bVar3) {
LAB_1000eb13:
    param_3 = (QTypedArrayData<> *)CONCAT31(param_3._1_3_,1);
  }
  else {
    pQStack_28 = QString::fromAscii_helper((char *)&param_1_100154b0,4);
    iStack_4 = 9;
    bVar2 = true;
    bVar3 = QString::endsWith((QString *)pQVar1,(QString *)&pQStack_28,0);
    param_3 = (QTypedArrayData<> *)((uint)param_3 & 0xffffff00);
    if (bVar3) goto LAB_1000eb13;
  }
  iStack_4 = 8;
  if (bVar2) {
    QString::~QString((QString *)&pQStack_28);
  }
  iStack_4._0_1_ = 1;
  iStack_4._1_3_ = 0;
  QString::~QString((QString *)&pQStack_2c);
  if ((char)param_3 == '\0') {
    QImage::QImage(param_2);
  }
  else {
    pQStack_2c = (QTypedArrayData<> *)0x0;
    param_3 = (QTypedArrayData<> *)0x0;
    pQStack_24 = QString::fromAscii_helper((char *)&param_1_100154a8,4);
    iStack_4._0_1_ = 10;
    bVar2 = QString::endsWith((QString *)pQVar1,(QString *)&pQStack_24,0);
    iStack_4 = CONCAT31(iStack_4._1_3_,1);
    QString::~QString((QString *)&pQStack_24);
    ppQVar15 = &pQStack_24;
    pQVar6 = (QByteArray *)QString::toLatin1((QString *)pQVar1);
    if (bVar2) {
      iVar4 = *piVar5;
      ppQVar12 = &param_2;
      uVar14 = 0;
      puVar10 = &local_30;
      uStack_8 = 0xb;
      pcVar7 = QByteArray::constData(pQVar6);
      (**(code **)(iVar4 + 0xf4))(pcVar7,puVar10,ppQVar12,uVar14);
    }
    else {
      iVar4 = *piVar5;
      ppQVar12 = &param_2;
      uVar14 = 0;
      puVar10 = &local_30;
      uStack_8 = 0xc;
      pcVar7 = QByteArray::constData(pQVar6);
      (**(code **)(iVar4 + 0xf8))(pcVar7,puVar10,ppQVar12,uVar14,ppQVar15);
    }
    iStack_4._0_1_ = 1;
    QByteArray::~QByteArray((QByteArray *)&pQStack_24);
    if ((pQStack_2c == (QTypedArrayData<> *)0x0) || (param_3 == (QTypedArrayData<> *)0x0)) {
      QImage::QImage(param_2);
    }
    else {
      QByteArray::QByteArray((QByteArray *)&pQStack_28);
      iStack_4._0_1_ = 0xd;
      QByteArray::resize((QByteArray *)&pQStack_28,(int)param_3 * (int)pQStack_2c * 4);
      pQStack_24 = QString::fromAscii_helper((char *)&param_1_100154a8,4);
      iStack_4._0_1_ = 0xe;
      bVar2 = QString::endsWith((QString *)pQVar1,(QString *)&pQStack_24,0);
      iStack_4._0_1_ = 0xd;
      QString::~QString((QString *)&pQStack_24);
      ppQVar15 = &pQStack_24;
      pQVar6 = (QByteArray *)QString::toLatin1((QString *)pQVar1);
      if (bVar2) {
        iVar4 = *piVar5;
        uStack_8 = 0xf;
        pcVar7 = QByteArray::data((QByteArray *)&pQStack_2c);
        ppQVar12 = &param_2;
        puVar10 = &local_30;
        pcVar9 = QByteArray::constData(pQVar6);
        (**(code **)(iVar4 + 0xf4))(pcVar9,puVar10,ppQVar12,pcVar7);
      }
      else {
        iVar4 = *piVar5;
        uStack_8 = 0x10;
        pcVar7 = QByteArray::data((QByteArray *)&pQStack_2c);
        ppQVar12 = &param_2;
        puVar10 = &local_30;
        pcVar9 = QByteArray::constData(pQVar6);
        (**(code **)(iVar4 + 0xf8))(pcVar9,puVar10,ppQVar12,pcVar7,ppQVar15);
      }
      param_3 = (QTypedArrayData<> *)CONCAT31(param_3._1_3_,0xd);
      QByteArray::~QByteArray(aQStack_18);
      QImage::QImage(aQStack_10,iStack_20,(int)param_6,0x11);
      param_3 = (QTypedArrayData<> *)CONCAT31(param_3._1_3_,0x11);
      iVar8 = 0;
      iVar4 = QImage::height(aQStack_10);
      if (0 < iVar4) {
        do {
          iVar4 = QImage::bytesPerLine(aQStack_10);
          _Size = QImage::bytesPerLine(aQStack_10);
          pcVar7 = QByteArray::constData((QByteArray *)aQStack_1c);
          pcVar7 = pcVar7 + iVar4 * iVar8;
          _Dst = QImage::scanLine(aQStack_10,iVar8);
          memcpy(_Dst,pcVar7,_Size);
          iVar8 = iVar8 + 1;
          iVar4 = QImage::height(aQStack_10);
        } while (iVar8 < iVar4);
      }
      piVar5 = (int *)QImage::size(aQStack_10);
      *param_6 = *piVar5;
      param_6[1] = piVar5[1];
      piVar5 = (int *)QImage::size(aQStack_14);
      pQVar1 = param_3;
      if ((((*piVar5 != *param_6) || (piVar5[1] != param_6[1])) && (-1 < *param_6)) &&
         (-1 < param_6[1])) {
        QImage::scaled((QImage *)aQStack_18,(QSize *)param_3,(AspectRatioMode)param_6,0);
        iStack_4._0_1_ = 0xd;
        QImage::~QImage(aQStack_1c);
        iStack_4._0_1_ = 1;
        QByteArray::~QByteArray((QByteArray *)&pQStack_28);
        iStack_4 = (uint)iStack_4._1_3_ << 8;
        QString::~QString((QString *)&local_30);
        ExceptionList = local_c;
        return (QImage *)pQVar1;
      }
      QImage::QImage((QImage *)param_3,(QImage *)aQStack_18);
      local_30 = local_30 | 1;
      QImage::~QImage((QImage *)aQStack_18);
      QByteArray::~QByteArray((QByteArray *)&pQStack_24);
    }
  }
LAB_1000ee5a:
  iStack_4 = (uint)iStack_4._1_3_ << 8;
  QString::~QString((QString *)&local_30);
  ExceptionList = local_c;
  return param_2;
}



QPixmap * __thiscall
FUN_1000ee90(void *this,QPixmap *param_1,undefined4 param_2,undefined4 param_3,undefined4 param_4)

{
  QPixmap *pQVar1;
  int iVar2;
  undefined4 uVar3;
  undefined4 uStack_2c;
  uint uStack_28;
  void *local_1c [2];
  uint uStack_14;
  QPixmap *local_c;
  undefined1 *puStack_8;
  undefined4 uStack_4;
  
  uStack_4 = 0xffffffff;
  puStack_8 = &LAB_10013023;
  local_c = (QPixmap *)ExceptionList;
  uStack_28 = DAT_10022088 ^ (uint)&stack0xffffffdc;
  ExceptionList = &local_c;
  if (*(int *)((int)this + 8) == 0) {
    uStack_2c = 0x1000eecf;
    QPixmap::QPixmap(param_1);
    ExceptionList = local_c;
    return param_1;
  }
  uStack_2c = 0x1000eeeb;
  iVar2 = FUN_100042b0(*(int *)((int)this + 8));
  if (iVar2 == 0) {
    uStack_2c = 0x1000eef9;
    QPixmap::QPixmap(param_1);
    ExceptionList = local_c;
    return param_1;
  }
  uStack_2c = param_4;
                    // WARNING: Load size is inaccurate
  uVar3 = (**(code **)(*this + 0xc))(local_1c,param_2,param_3);
  pQVar1 = local_c;
  uStack_14 = 1;
  QPixmap::fromImage(local_c,uVar3,0);
  uStack_14 = uStack_14 & 0xffffff00;
  QImage::~QImage((QImage *)&uStack_2c);
  ExceptionList = local_1c[0];
  return pQVar1;
}



void __thiscall FUN_1000ef80(void *this,undefined4 param_1)

{
  *(undefined4 *)((int)this + 8) = param_1;
  return;
}



QMetaObject * __fastcall FUN_1000ef90(int param_1)

{
  QMetaObject *pQVar1;
  
  if (*(int *)(*(QObjectData **)(param_1 + 4) + 0x18) != 0) {
                    // WARNING: Could not recover jumptable at 0x1000ef99. Too many branches
                    // WARNING: Treating indirect jump as call
    pQVar1 = QObjectData::dynamicMetaObject(*(QObjectData **)(param_1 + 4));
    return pQVar1;
  }
  return (QMetaObject *)&DAT_10022010;
}



int __thiscall QObject::qt_metacall(QObject *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x1000efb0. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



void * __thiscall FUN_1000efc0(void *this,byte *param_1)

{
  byte bVar1;
  char *pcVar2;
  uint uVar3;
  void *pvVar4;
  byte *pbVar5;
  bool bVar6;
  
  if (param_1 == (byte *)0x0) {
    return (void *)0x0;
  }
  pcVar2 = "BlackMesaUIRenderer";
  pbVar5 = param_1;
  do {
    bVar1 = *pbVar5;
    bVar6 = bVar1 < (byte)*pcVar2;
    if (bVar1 != *pcVar2) {
LAB_1000f000:
      uVar3 = -(uint)bVar6 | 1;
      goto LAB_1000f005;
    }
    if (bVar1 == 0) break;
    bVar1 = pbVar5[1];
    bVar6 = bVar1 < ((byte *)pcVar2)[1];
    if (bVar1 != ((byte *)pcVar2)[1]) goto LAB_1000f000;
    pbVar5 = pbVar5 + 2;
    pcVar2 = (char *)((byte *)pcVar2 + 2);
  } while (bVar1 != 0);
  uVar3 = 0;
LAB_1000f005:
  if (uVar3 == 0) {
    return this;
  }
  pvVar4 = QObject::qt_metacast((QObject *)this,(char *)param_1);
  return pvVar4;
}



QMetaObject * __fastcall FUN_1000f020(int param_1)

{
  QMetaObject *pQVar1;
  
  if (*(int *)(*(QObjectData **)(param_1 + 4) + 0x18) != 0) {
                    // WARNING: Could not recover jumptable at 0x1000f029. Too many branches
                    // WARNING: Treating indirect jump as call
    pQVar1 = QObjectData::dynamicMetaObject(*(QObjectData **)(param_1 + 4));
    return pQVar1;
  }
  return (QMetaObject *)&DAT_10022028;
}



int __thiscall FUN_1000f040(void *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
  iVar1 = QObject::qt_metacall((QObject *)this,param_1,param_2,param_3);
  if (-1 < iVar1) {
    if (param_1 == 0) {
      if (iVar1 < 4) {
        FUN_1000f140((QObject *)this,0,iVar1);
        return iVar1 + -4;
      }
    }
    else {
      if (param_1 != 0xc) {
        return iVar1;
      }
      if (iVar1 < 4) {
        *(undefined4 *)*param_3 = 0xffffffff;
      }
    }
    iVar1 = iVar1 + -4;
  }
  return iVar1;
}



void * __thiscall FUN_1000f0a0(void *this,byte *param_1)

{
  byte bVar1;
  byte *pbVar2;
  uint uVar3;
  void *pvVar4;
  char *pcVar5;
  bool bVar6;
  
  if (param_1 != (byte *)0x0) {
    pcVar5 = "BlackMesaUIInstance";
    pbVar2 = param_1;
    do {
      bVar1 = *pbVar2;
      bVar6 = bVar1 < (byte)*pcVar5;
      if (bVar1 != *pcVar5) {
LAB_1000f0e0:
        uVar3 = -(uint)bVar6 | 1;
        goto LAB_1000f0e5;
      }
      if (bVar1 == 0) break;
      bVar1 = pbVar2[1];
      bVar6 = bVar1 < ((byte *)pcVar5)[1];
      if (bVar1 != ((byte *)pcVar5)[1]) goto LAB_1000f0e0;
      pbVar2 = pbVar2 + 2;
      pcVar5 = (char *)((byte *)pcVar5 + 2);
    } while (bVar1 != 0);
    uVar3 = 0;
LAB_1000f0e5:
    if (uVar3 == 0) {
      return this;
    }
    pcVar5 = "IProxyExternalUI";
    pbVar2 = param_1;
    do {
      bVar1 = *pbVar2;
      bVar6 = bVar1 < (byte)*pcVar5;
      if (bVar1 != *pcVar5) {
LAB_1000f117:
        uVar3 = -(uint)bVar6 | 1;
        goto LAB_1000f11c;
      }
      if (bVar1 == 0) break;
      bVar1 = pbVar2[1];
      bVar6 = bVar1 < ((byte *)pcVar5)[1];
      if (bVar1 != ((byte *)pcVar5)[1]) goto LAB_1000f117;
      pbVar2 = pbVar2 + 2;
      pcVar5 = (char *)((byte *)pcVar5 + 2);
    } while (bVar1 != 0);
    uVar3 = 0;
LAB_1000f11c:
    if (uVar3 != 0) {
      pvVar4 = QObject::qt_metacast((QObject *)this,(char *)param_1);
      return pvVar4;
    }
    if (this != (void *)0x0) {
      return (void *)((int)this + 8);
    }
  }
  return (void *)0x0;
}



void __cdecl FUN_1000f140(QObject *param_1,int param_2,undefined4 param_3)

{
  if (param_2 == 0) {
    switch(param_3) {
    case 0:
      FUN_10005f20(param_1);
      return;
    case 1:
      FUN_10005d20(param_1);
      return;
    case 2:
      FUN_10005a40((int)param_1);
      return;
    case 3:
      FUN_10005900((int)param_1);
      return;
    }
  }
  return;
}



QMetaObject * __fastcall FUN_1000f190(int param_1)

{
  QMetaObject *pQVar1;
  
  if (*(int *)(*(QObjectData **)(param_1 + 4) + 0x18) != 0) {
                    // WARNING: Could not recover jumptable at 0x1000f199. Too many branches
                    // WARNING: Treating indirect jump as call
    pQVar1 = QObjectData::dynamicMetaObject(*(QObjectData **)(param_1 + 4));
    return pQVar1;
  }
  return (QMetaObject *)&DAT_10022058;
}



QMetaObject * __fastcall FUN_1000f1b0(int param_1)

{
  QMetaObject *pQVar1;
  
  if (*(int *)(*(QObjectData **)(param_1 + 4) + 0x18) != 0) {
                    // WARNING: Could not recover jumptable at 0x1000f1b9. Too many branches
                    // WARNING: Treating indirect jump as call
    pQVar1 = QObjectData::dynamicMetaObject(*(QObjectData **)(param_1 + 4));
    return pQVar1;
  }
  return (QMetaObject *)&DAT_10022040;
}



int __thiscall
QNetworkAccessManager::qt_metacall
          (QNetworkAccessManager *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x1000f1d0. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



int __thiscall
QNetworkReply::qt_metacall(QNetworkReply *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x1000f1e0. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



void * __thiscall FUN_1000f1f0(void *this,byte *param_1)

{
  byte bVar1;
  char *pcVar2;
  uint uVar3;
  void *pvVar4;
  byte *pbVar5;
  bool bVar6;
  
  if (param_1 == (byte *)0x0) {
    return (void *)0x0;
  }
  pcVar2 = "BlackMesaUINetworkAccessManager";
  pbVar5 = param_1;
  do {
    bVar1 = *pbVar5;
    bVar6 = bVar1 < (byte)*pcVar2;
    if (bVar1 != *pcVar2) {
LAB_1000f230:
      uVar3 = -(uint)bVar6 | 1;
      goto LAB_1000f235;
    }
    if (bVar1 == 0) break;
    bVar1 = pbVar5[1];
    bVar6 = bVar1 < ((byte *)pcVar2)[1];
    if (bVar1 != ((byte *)pcVar2)[1]) goto LAB_1000f230;
    pbVar5 = pbVar5 + 2;
    pcVar2 = (char *)((byte *)pcVar2 + 2);
  } while (bVar1 != 0);
  uVar3 = 0;
LAB_1000f235:
  if (uVar3 == 0) {
    return this;
  }
  pvVar4 = QNetworkAccessManager::qt_metacast((QNetworkAccessManager *)this,(char *)param_1);
  return pvVar4;
}



void * __thiscall FUN_1000f250(void *this,byte *param_1)

{
  byte bVar1;
  char *pcVar2;
  uint uVar3;
  void *pvVar4;
  byte *pbVar5;
  bool bVar6;
  
  if (param_1 == (byte *)0x0) {
    return (void *)0x0;
  }
  pcVar2 = "BlackMesaUINetworkReply";
  pbVar5 = param_1;
  do {
    bVar1 = *pbVar5;
    bVar6 = bVar1 < (byte)*pcVar2;
    if (bVar1 != *pcVar2) {
LAB_1000f290:
      uVar3 = -(uint)bVar6 | 1;
      goto LAB_1000f295;
    }
    if (bVar1 == 0) break;
    bVar1 = pbVar5[1];
    bVar6 = bVar1 < ((byte *)pcVar2)[1];
    if (bVar1 != ((byte *)pcVar2)[1]) goto LAB_1000f290;
    pbVar5 = pbVar5 + 2;
    pcVar2 = (char *)((byte *)pcVar2 + 2);
  } while (bVar1 != 0);
  uVar3 = 0;
LAB_1000f295:
  if (uVar3 == 0) {
    return this;
  }
  pvVar4 = QNetworkReply::qt_metacast((QNetworkReply *)this,(char *)param_1);
  return pvVar4;
}



void * __thiscall FUN_1000f2b0(void *this,int *param_1)

{
  int *piVar1;
  int iVar2;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_10013040;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
  piVar1 = (int *)*param_1;
  *(int **)this = piVar1;
  if (*piVar1 == 0) {
    QListData::detach((QListData *)this,piVar1[1]);
                    // WARNING: Load size is inaccurate
    iVar2 = *this;
    local_8 = 0;
    FUN_1000d2b0((QString *)(iVar2 + (*(int *)(iVar2 + 8) + 4) * 4),
                 (QString *)(iVar2 + (*(int *)(iVar2 + 0xc) + 4) * 4),
                 *param_1 + *(int *)(*param_1 + 8) * 4 + 0x10);
  }
  else if (*piVar1 != -1) {
    LOCK();
    *piVar1 = *piVar1 + 1;
    UNLOCK();
  }
  ExceptionList = local_10;
  return this;
}



void Catch_All_1000f34e(void)

{
  int unaff_EBP;
  
  QListData::dispose((Data *)**(undefined4 **)(unaff_EBP + -0x14));
                    // WARNING: Subroutine does not return
  _CxxThrowException((void *)0x0,(ThrowInfo *)0x0);
}



void * __thiscall FUN_1000f370(void *this,undefined4 *param_1)

{
  int iVar1;
  undefined4 uVar2;
  Data *pDVar3;
  
  uVar2 = *param_1;
  *param_1 = shared_null_exref;
                    // WARNING: Load size is inaccurate
  pDVar3 = *this;
  *(undefined4 *)this = uVar2;
  if (*(int *)pDVar3 != 0) {
    if (*(int *)pDVar3 == -1) {
      return this;
    }
    LOCK();
    iVar1 = *(int *)pDVar3;
    *(int *)pDVar3 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return this;
    }
  }
  FUN_10009a40(pDVar3);
  return this;
}



void * __thiscall FUN_1000f3b0(void *this,undefined4 *param_1)

{
  int iVar1;
  undefined4 uVar2;
  QMapDataBase *this_00;
  
  uVar2 = *param_1;
  *param_1 = shared_null_exref;
                    // WARNING: Load size is inaccurate
  this_00 = *this;
  *(undefined4 *)this = uVar2;
  if (*(int *)this_00 != 0) {
    if (*(int *)this_00 == -1) {
      return this;
    }
    LOCK();
    iVar1 = *(int *)this_00;
    *(int *)this_00 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return this;
    }
  }
  if (*(int *)(this_00 + 0xc) != 0) {
    FUN_100041f0(*(int *)(this_00 + 0xc));
    QMapDataBase::freeTree(this_00,*(QMapNodeBase **)(this_00 + 0xc),8);
  }
  QMapDataBase::freeData(this_00);
  return this;
}



void * __thiscall FUN_1000f410(void *this,int *param_1)

{
  int *piVar1;
  
                    // WARNING: Load size is inaccurate
  if (*this != *param_1) {
    FUN_1000f2b0(&param_1,param_1);
                    // WARNING: Load size is inaccurate
    piVar1 = *this;
    *(int **)this = param_1;
    param_1 = piVar1;
    FUN_10009400(&param_1);
  }
  return this;
}



void __fastcall FUN_1000f450(QObject *param_1)

{
  QMetaObject::activate(param_1,(QMetaObject *)&param_6_10022070,2,(void **)0x0);
  return;
}



void __fastcall FUN_1000f470(QObject *param_1)

{
  QMetaObject::activate(param_1,(QMetaObject *)&param_6_10022070,7,(void **)0x0);
  return;
}



void __fastcall FUN_1000f490(QObject *param_1)

{
  QMetaObject::activate(param_1,(QMetaObject *)&param_6_10022070,9,(void **)0x0);
  return;
}



void __fastcall FUN_1000f4b0(QObject *param_1)

{
  QMetaObject::activate(param_1,(QMetaObject *)&param_6_10022070,8,(void **)0x0);
  return;
}



void __thiscall FUN_1000f4d0(void *this,undefined4 param_1)

{
  void *local_8;
  undefined4 local_4;
  
  local_4 = param_1;
  local_8 = (void *)0x0;
  QMetaObject::activate((QObject *)this,(QMetaObject *)&param_6_10022070,10,&local_8);
  return;
}



void __fastcall FUN_1000f500(QObject *param_1)

{
  QMetaObject::activate(param_1,(QMetaObject *)&param_6_10022070,4,(void **)0x0);
  return;
}



void __fastcall FUN_1000f520(QObject *param_1)

{
  QMetaObject::activate(param_1,(QMetaObject *)&param_6_10022070,5,(void **)0x0);
  return;
}



void __fastcall FUN_1000f540(QObject *param_1)

{
  void *local_8;
  undefined1 *local_4;
  
  local_4 = &stack0x00000004;
  local_8 = (void *)0x0;
  QMetaObject::activate(param_1,(QMetaObject *)&param_6_10022070,6,&local_8);
  return;
}



void __thiscall FUN_1000f570(void *this,undefined4 param_1,undefined4 param_2,undefined4 param_3)

{
  void *local_14;
  undefined4 *local_10;
  undefined4 local_c;
  undefined4 local_8;
  uint local_4;
  
  local_4 = DAT_10022088 ^ (uint)&local_14;
  local_c = param_2;
  local_10 = &param_1;
  local_14 = (void *)0x0;
  local_8 = param_3;
  QMetaObject::activate((QObject *)this,(QMetaObject *)&param_6_10022070,1,&local_14);
  FUN_10010b2e(local_4 ^ (uint)&local_14);
  return;
}



void __thiscall FUN_1000f5d0(void *this,undefined4 param_1)

{
  void *local_14;
  undefined4 local_10;
  undefined1 *local_c;
  undefined1 *local_8;
  uint local_4;
  
  local_4 = DAT_10022088 ^ (uint)&local_14;
  local_10 = param_1;
  local_c = &stack0x00000008;
  local_8 = &stack0x0000000c;
  local_14 = (void *)0x0;
  QMetaObject::activate((QObject *)this,(QMetaObject *)&param_6_10022070,0,&local_14);
  FUN_10010b2e(local_4 ^ (uint)&local_14);
  return;
}



void __thiscall FUN_1000f630(void *this,undefined4 param_1)

{
  void *local_8;
  undefined4 local_4;
  
  local_4 = param_1;
  local_8 = (void *)0x0;
  QMetaObject::activate((QObject *)this,(QMetaObject *)&param_6_10022070,0xc,&local_8);
  return;
}



void __thiscall FUN_1000f660(void *this,undefined4 param_1,undefined4 param_2)

{
  void *local_10;
  undefined4 local_c;
  undefined4 local_8;
  uint local_4;
  
  local_4 = DAT_10022088 ^ (uint)&local_10;
  local_c = param_1;
  local_10 = (void *)0x0;
  local_8 = param_2;
  QMetaObject::activate((QObject *)this,(QMetaObject *)&param_6_10022070,0xb,&local_10);
  FUN_10010b2e(local_4 ^ (uint)&local_10);
  return;
}



QMetaObject ** __fastcall FUN_1000f6b0(int param_1)

{
  QMetaObject *pQVar1;
  
  if (*(int *)(*(QObjectData **)(param_1 + 4) + 0x18) != 0) {
                    // WARNING: Could not recover jumptable at 0x1000f6b9. Too many branches
                    // WARNING: Treating indirect jump as call
    pQVar1 = QObjectData::dynamicMetaObject(*(QObjectData **)(param_1 + 4));
    return (QMetaObject **)pQVar1;
  }
  return &param_6_10022070;
}



void __fastcall FUN_1000f6d0(QObject *param_1)

{
  void *local_8;
  undefined1 *local_4;
  
  local_4 = &stack0x00000004;
  local_8 = (void *)0x0;
  QMetaObject::activate(param_1,(QMetaObject *)&param_6_10022070,0xd,&local_8);
  return;
}



int __thiscall FUN_1000f700(void *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
  iVar1 = QObject::qt_metacall((QObject *)this,param_1,param_2,param_3);
  if (-1 < iVar1) {
    if (param_1 == 0) {
      if (iVar1 < 0x55) {
        FUN_1000f7c0((QObject *)this,0,iVar1,(int *)param_3);
        return iVar1 + -0x55;
      }
    }
    else {
      if (param_1 != 0xc) {
        return iVar1;
      }
      if (iVar1 < 0x55) {
        *(undefined4 *)*param_3 = 0xffffffff;
      }
    }
    iVar1 = iVar1 + -0x55;
  }
  return iVar1;
}



void * __thiscall FUN_1000f760(void *this,byte *param_1)

{
  byte bVar1;
  char *pcVar2;
  uint uVar3;
  void *pvVar4;
  byte *pbVar5;
  bool bVar6;
  
  if (param_1 == (byte *)0x0) {
    return (void *)0x0;
  }
  pcVar2 = "BlackMesaUIEngineClient";
  pbVar5 = param_1;
  do {
    bVar1 = *pbVar5;
    bVar6 = bVar1 < (byte)*pcVar2;
    if (bVar1 != *pcVar2) {
LAB_1000f7a0:
      uVar3 = -(uint)bVar6 | 1;
      goto LAB_1000f7a5;
    }
    if (bVar1 == 0) break;
    bVar1 = pbVar5[1];
    bVar6 = bVar1 < ((byte *)pcVar2)[1];
    if (bVar1 != ((byte *)pcVar2)[1]) goto LAB_1000f7a0;
    pbVar5 = pbVar5 + 2;
    pcVar2 = (char *)((byte *)pcVar2 + 2);
  } while (bVar1 != 0);
  uVar3 = 0;
LAB_1000f7a5:
  if (uVar3 == 0) {
    return this;
  }
  pvVar4 = QObject::qt_metacast((QObject *)this,(char *)param_1);
  return pvVar4;
}



void __cdecl FUN_1000f7c0(QObject *param_1,int param_2,undefined4 param_3,int *param_4)

{
  undefined8 *puVar1;
  undefined4 *puVar2;
  code *pcVar3;
  int *piVar4;
  undefined1 uVar5;
  undefined4 uVar6;
  QString *this;
  float10 fVar7;
  undefined4 local_1c;
  undefined8 local_18;
  void *local_10;
  void *local_c;
  undefined1 *puStack_8;
  undefined4 local_4;
  
  piVar4 = param_4;
  local_4 = 0xffffffff;
  puStack_8 = &LAB_10013081;
  local_c = ExceptionList;
  if (param_2 != 0) {
    if (param_2 != 10) {
      return;
    }
    puVar2 = (undefined4 *)*param_4;
    pcVar3 = *(code **)param_4[1];
    if (pcVar3 == FUN_1000f5d0) {
      *puVar2 = 0;
      return;
    }
    if (pcVar3 == FUN_1000f570) {
      *puVar2 = 1;
      return;
    }
    if (pcVar3 == FUN_1000f450) {
      *puVar2 = 2;
      return;
    }
    if (pcVar3 == FUN_10010780) {
      *puVar2 = 3;
      return;
    }
    if (pcVar3 == FUN_1000f500) {
      *puVar2 = 4;
      return;
    }
    if (pcVar3 == FUN_1000f520) {
      *puVar2 = 5;
      return;
    }
    if (pcVar3 != FUN_1000f540) {
      if (pcVar3 == FUN_1000f470) {
        *puVar2 = 7;
        return;
      }
      if (pcVar3 == FUN_1000f4b0) {
        *puVar2 = 8;
        return;
      }
      if (pcVar3 == FUN_1000f490) {
        *puVar2 = 9;
        return;
      }
      if (pcVar3 != FUN_1000f4d0) {
        if (pcVar3 == FUN_1000f660) {
          *puVar2 = 0xb;
          return;
        }
        if (pcVar3 != FUN_1000f630) {
          if (pcVar3 != FUN_1000f6d0) {
            return;
          }
          *puVar2 = 0xd;
          return;
        }
        *puVar2 = 0xc;
        return;
      }
      *puVar2 = 10;
      return;
    }
    *puVar2 = 6;
    return;
  }
  ExceptionList = &local_c;
  switch(param_3) {
  case 0:
    FUN_1000f5d0(param_1,param_4[1]);
    ExceptionList = local_c;
    return;
  case 1:
    FUN_1000f570(param_1,(uint)*(byte *)param_4[1],param_4[2],param_4[3]);
    ExceptionList = local_c;
    return;
  case 2:
    FUN_1000f450(param_1);
    ExceptionList = local_c;
    return;
  case 3:
    FUN_10010780(param_1,*(undefined4 *)param_4[1],param_4[2]);
    ExceptionList = local_c;
    return;
  case 4:
    FUN_1000f500(param_1);
    ExceptionList = local_c;
    return;
  case 5:
    FUN_1000f520(param_1);
    ExceptionList = local_c;
    return;
  case 6:
    FUN_1000f540(param_1);
    ExceptionList = local_c;
    return;
  case 7:
    FUN_1000f470(param_1);
    ExceptionList = local_c;
    return;
  case 8:
    FUN_1000f4b0(param_1);
    ExceptionList = local_c;
    return;
  case 9:
    FUN_1000f490(param_1);
    ExceptionList = local_c;
    return;
  case 10:
    FUN_1000f4d0(param_1,param_4[1]);
    ExceptionList = local_c;
    return;
  case 0xb:
    FUN_1000f660(param_1,param_4[1],param_4[2]);
    ExceptionList = local_c;
    return;
  case 0xc:
    FUN_1000f630(param_1,param_4[1]);
    ExceptionList = local_c;
    return;
  case 0xd:
    FUN_1000f6d0(param_1);
    ExceptionList = local_c;
    return;
  case 0xe:
    FUN_1000e5e0(param_1);
    ExceptionList = local_c;
    return;
  case 0xf:
    FUN_1000a110(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x10:
    FUN_1000a010(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x11:
    FUN_1000a090(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x12:
    uVar5 = FUN_1000b1b0((int)param_1);
    if ((undefined1 *)*param_4 != (undefined1 *)0x0) {
      *(undefined1 *)*param_4 = uVar5;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x13:
    uVar5 = FUN_1000b1c0((int)param_1);
    if ((undefined1 *)*param_4 != (undefined1 *)0x0) {
      *(undefined1 *)*param_4 = uVar5;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x14:
    uVar5 = FUN_1000b1d0((int)param_1);
    if ((undefined1 *)*param_4 != (undefined1 *)0x0) {
      *(undefined1 *)*param_4 = uVar5;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x15:
    FUN_1000e6c0((int)param_1);
    ExceptionList = local_c;
    return;
  case 0x16:
    FUN_1000a190((int)param_1);
    goto LAB_1000faf7;
  case 0x17:
    FUN_1000a960(param_1,&param_2);
    if ((void *)*param_4 != (void *)0x0) {
      FUN_1000f3b0((void *)*param_4,&param_2);
    }
    FUN_100034b0(&param_2);
    ExceptionList = local_c;
    return;
  case 0x18:
    uVar6 = FUN_1000ab70(param_1,(QString *)param_4[1]);
    if ((undefined4 *)*piVar4 != (undefined4 *)0x0) {
      *(undefined4 *)*piVar4 = uVar6;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x19:
    FUN_1000e520(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x1a:
    uVar6 = FUN_1000afe0((int)param_1);
    if ((undefined4 *)*param_4 != (undefined4 *)0x0) {
      *(undefined4 *)*param_4 = uVar6;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x1b:
    FUN_1000ac00((int)param_1);
    goto LAB_1000fbec;
  case 0x1c:
    FUN_1000a590(param_1,&param_2);
    goto LAB_1000fbec;
  case 0x1d:
    FUN_1000af10(param_1,&param_2);
    goto LAB_1000fbec;
  case 0x1e:
    FUN_1000ac90((int)param_1);
    goto LAB_1000fbec;
  case 0x1f:
    FUN_1000ad20((int)param_1);
    goto LAB_1000fbec;
  case 0x20:
    uVar6 = FUN_1000adb0((int)param_1);
    if ((undefined4 *)*param_4 != (undefined4 *)0x0) {
      *(undefined4 *)*param_4 = uVar6;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x21:
    FUN_1000b2f0(param_1,&param_2,(QString *)param_4[1]);
    this = (QString *)*piVar4;
    goto LAB_1000fbf2;
  case 0x22:
    FUN_1000b390(param_1,&param_2,(QString *)param_4[1]);
    this = (QString *)*piVar4;
    goto LAB_1000fbf2;
  case 0x23:
    FUN_1000b210(param_1,&param_2,*(undefined4 *)param_4[1]);
    this = (QString *)*piVar4;
    goto LAB_1000fbf2;
  case 0x24:
    FUN_1000b240(param_1,&param_2,*(undefined4 *)param_4[1]);
    this = (QString *)*piVar4;
    goto LAB_1000fbf2;
  case 0x25:
    uVar6 = FUN_1000b270(param_1,(QString *)param_4[1]);
    if ((undefined4 *)*piVar4 != (undefined4 *)0x0) {
      *(undefined4 *)*piVar4 = uVar6;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x26:
    FUN_1000e1c0((int)param_1);
    ExceptionList = local_c;
    return;
  case 0x27:
    uVar6 = FUN_1000abf0((int)param_1);
    if ((undefined4 *)*param_4 != (undefined4 *)0x0) {
      *(undefined4 *)*param_4 = uVar6;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x28:
    FUN_1000aff0((int)param_1);
    goto LAB_1000fbec;
  case 0x29:
    uVar6 = FUN_1000a660((int)param_1);
    if ((undefined4 *)*param_4 != (undefined4 *)0x0) {
      *(undefined4 *)*param_4 = uVar6;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x2a:
    uVar5 = FUN_1000b200((int)param_1);
    if ((undefined1 *)*param_4 != (undefined1 *)0x0) {
      *(undefined1 *)*param_4 = uVar5;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x2b:
    uVar5 = FUN_1000b1f0((int)param_1);
    if ((undefined1 *)*param_4 != (undefined1 *)0x0) {
      *(undefined1 *)*param_4 = uVar5;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x2c:
    FUN_1000cd90((int)param_1);
    goto LAB_1000faf7;
  case 0x2d:
    FUN_1000d490(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x2e:
    uVar6 = FUN_1000d400(param_1,(QString *)param_4[1]);
    if ((undefined4 *)*piVar4 != (undefined4 *)0x0) {
      *(undefined4 *)*piVar4 = uVar6;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x2f:
    uVar5 = FUN_1000b1e0((int)param_1);
    if ((undefined1 *)*piVar4 != (undefined1 *)0x0) {
      *(undefined1 *)*piVar4 = uVar5;
      ExceptionList = local_10;
      return;
    }
    break;
  case 0x30:
    FUN_1000e6b0((int)param_1);
    ExceptionList = local_10;
    return;
  case 0x31:
    FUN_1000e5c0(param_1,*(undefined4 *)param_4[1],*(undefined4 *)param_4[2]);
    ExceptionList = local_c;
    return;
  case 0x32:
    FUN_1000adc0(param_1,(QString *)&param_2,(QString *)param_4[1]);
    this = (QString *)*piVar4;
    goto LAB_1000fbf2;
  case 0x33:
    uVar5 = FUN_1000b0f0(param_1,param_4[1],(QString *)param_4[2]);
    if ((undefined1 *)*piVar4 != (undefined1 *)0x0) {
      *(undefined1 *)*piVar4 = uVar5;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x34:
    FUN_1000c3f0(param_1,(QString *)&param_2,param_4[1],(QString *)param_4[2]);
    local_4 = 0;
    if ((void *)*piVar4 != (void *)0x0) {
      FUN_1000f410((void *)*piVar4,&param_2);
    }
    local_4 = 0xffffffff;
    FUN_10009400(&param_2);
    ExceptionList = local_c;
    return;
  case 0x35:
    fVar7 = FUN_1000a700(param_1,(QString *)param_4[1]);
    if ((float *)*piVar4 != (float *)0x0) {
      *(float *)*piVar4 = (float)fVar7;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x36:
    uVar6 = FUN_1000a790(param_1,(QString *)param_4[1]);
    if ((undefined4 *)*piVar4 != (undefined4 *)0x0) {
      *(undefined4 *)*piVar4 = uVar6;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x37:
    uVar5 = FUN_1000a670(param_1,(QString *)param_4[1]);
    if ((undefined1 *)*piVar4 != (undefined1 *)0x0) {
      *(undefined1 *)*piVar4 = uVar5;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x38:
    FUN_1000a8b0(param_1,&local_18,(QString *)param_4[1]);
    puVar1 = (undefined8 *)*piVar4;
    if (puVar1 != (undefined8 *)0x0) {
      *puVar1 = local_18;
      *(void **)(puVar1 + 1) = local_10;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x39:
    FUN_1000a810(param_1,&param_2,(QString *)param_4[1]);
    this = (QString *)*piVar4;
    goto LAB_1000fbf2;
  case 0x3a:
    FUN_1000e2b0(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x3b:
    FUN_1000e340(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x3c:
    FUN_1000e230(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x3d:
    FUN_1000e470(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x3e:
    FUN_1000e3c0(param_1,param_4[1],(QString *)param_4[2]);
    ExceptionList = local_c;
    return;
  case 0x3f:
    FUN_1000c190(param_1,&param_2,(QString *)param_4[1]);
    local_4 = 1;
    if ((void *)*piVar4 != (void *)0x0) {
      FUN_1000f410((void *)*piVar4,&param_2);
    }
    local_4 = 0xffffffff;
    FUN_10009400(&param_2);
    ExceptionList = local_c;
    return;
  case 0x40:
    FUN_1000c2a0(param_1,(QString *)&param_2,param_4[1],(QString *)param_4[2]);
    local_4 = 2;
    if ((void *)*piVar4 != (void *)0x0) {
      FUN_1000f410((void *)*piVar4,&param_2);
    }
    local_4 = 0xffffffff;
    FUN_10009400(&param_2);
    ExceptionList = local_c;
    return;
  case 0x41:
    FUN_1000b090((int)param_1);
    ExceptionList = local_c;
    return;
  case 0x42:
    FUN_1000e060((int)param_1);
    ExceptionList = local_c;
    return;
  case 0x43:
    FUN_1000e5b0((int)param_1);
    ExceptionList = local_10;
    return;
  case 0x44:
    FUN_1000e5a0((int)param_1);
    ExceptionList = local_10;
    return;
  case 0x45:
    FUN_1000c540((QTypedArrayData<> *)param_1);
LAB_1000faf7:
    if ((void *)*param_4 != (void *)0x0) {
      FUN_1000f370((void *)*param_4,&param_2);
    }
    FUN_10009460(&param_2);
    ExceptionList = local_c;
    return;
  case 0x46:
    uVar5 = FUN_1000e070(param_1,(QString *)param_4[1]);
    if ((undefined1 *)*piVar4 != (undefined1 *)0x0) {
      *(undefined1 *)*piVar4 = uVar5;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x47:
    FUN_10009740(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x48:
    FUN_100097c0(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x49:
    FUN_1000d510(param_1,param_4[1],(QString *)param_4[2]);
    ExceptionList = local_c;
    return;
  case 0x4a:
    FUN_1000d200(param_1,(QString *)param_4[1]);
    ExceptionList = local_c;
    return;
  case 0x4b:
    FUN_1000e100(param_1,(uint)&param_2);
    goto LAB_1000fbec;
  case 0x4c:
    FUN_1000e130(param_1,(uint)&param_2);
    goto LAB_1000fbec;
  case 0x4d:
    FUN_1000e160(param_1,(uint)&param_2);
    goto LAB_1000fbec;
  case 0x4e:
    FUN_1000e190(param_1,(uint)&param_2);
    goto LAB_1000fbec;
  case 0x4f:
    FUN_1000e1d0(param_1,(uint)&param_2);
    goto LAB_1000fbec;
  case 0x50:
    FUN_1000e200(param_1,(uint)&param_2);
LAB_1000fbec:
    this = (QString *)*param_4;
LAB_1000fbf2:
    if (this != (QString *)0x0) {
      QString::operator=(this,(QString *)&param_2);
    }
    QString::~QString((QString *)&param_2);
    ExceptionList = local_c;
    return;
  case 0x51:
    FUN_1000d860(param_1,(QString *)&param_2,param_4[1],(QString *)param_4[2]);
    this = (QString *)*piVar4;
    goto LAB_1000fbf2;
  case 0x52:
    FUN_1000bd40(param_1,(QJsonArray *)&local_18);
    local_4 = 3;
    if ((QJsonArray *)*param_4 != (QJsonArray *)0x0) {
      QJsonArray::operator=((QJsonArray *)*param_4,(QJsonArray *)&local_18);
    }
    local_4 = 0xffffffff;
    QJsonArray::~QJsonArray((QJsonArray *)&local_18);
    ExceptionList = local_c;
    return;
  case 0x53:
    uVar6 = FUN_1000b080((int)param_1);
    if ((undefined4 *)*param_4 != (undefined4 *)0x0) {
      *(undefined4 *)*param_4 = uVar6;
      ExceptionList = local_c;
      return;
    }
    break;
  case 0x54:
    FUN_1000b430((int)param_1);
    if ((void *)*param_4 != (void *)0x0) {
      FUN_1000f370((void *)*param_4,&local_1c);
    }
    FUN_10009460(&local_1c);
    ExceptionList = local_c;
    return;
  }
  ExceptionList = local_c;
  return;
}



void __thiscall FUN_10010780(void *this,undefined4 param_1,undefined4 param_2)

{
  void *local_10;
  undefined4 *local_c;
  undefined4 local_8;
  uint local_4;
  
  local_4 = DAT_10022088 ^ (uint)&local_10;
  local_c = &param_1;
  local_8 = param_2;
  local_10 = (void *)0x0;
  QMetaObject::activate((QObject *)this,(QMetaObject *)&param_6_10022070,3,&local_10);
  FUN_10010b2e(local_4 ^ (uint)&local_10);
  return;
}



QAccessibleInterface * __thiscall QQuickWindow::accessibleRoot(QQuickWindow *this)

{
  QAccessibleInterface *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x100107cc. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = accessibleRoot(this);
  return pQVar1;
}



bool __thiscall QQuickWindow::event(QQuickWindow *this,QEvent *param_1)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x100107d2. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = event(this,param_1);
  return bVar1;
}



void __thiscall QQuickWindow::exposeEvent(QQuickWindow *this,QExposeEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x100107d8. Too many branches
                    // WARNING: Treating indirect jump as call
  exposeEvent(this,param_1);
  return;
}



void __thiscall QQuickWindow::focusInEvent(QQuickWindow *this,QFocusEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x100107de. Too many branches
                    // WARNING: Treating indirect jump as call
  focusInEvent(this,param_1);
  return;
}



QObject * __thiscall QQuickWindow::focusObject(QQuickWindow *this)

{
  QObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x100107e4. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = focusObject(this);
  return pQVar1;
}



void __thiscall QQuickWindow::focusOutEvent(QQuickWindow *this,QFocusEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x100107ea. Too many branches
                    // WARNING: Treating indirect jump as call
  focusOutEvent(this,param_1);
  return;
}



void __thiscall QQuickWindow::hideEvent(QQuickWindow *this,QHideEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x100107f0. Too many branches
                    // WARNING: Treating indirect jump as call
  hideEvent(this,param_1);
  return;
}



void __thiscall QQuickWindow::keyPressEvent(QQuickWindow *this,QKeyEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x100107f6. Too many branches
                    // WARNING: Treating indirect jump as call
  keyPressEvent(this,param_1);
  return;
}



void __thiscall QQuickWindow::keyReleaseEvent(QQuickWindow *this,QKeyEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x100107fc. Too many branches
                    // WARNING: Treating indirect jump as call
  keyReleaseEvent(this,param_1);
  return;
}



QMetaObject * __thiscall QQuickRenderControl::metaObject(QQuickRenderControl *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010802. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



QMetaObject * __thiscall QQuickWindow::metaObject(QQuickWindow *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010808. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



void __thiscall QQuickWindow::mouseDoubleClickEvent(QQuickWindow *this,QMouseEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x1001080e. Too many branches
                    // WARNING: Treating indirect jump as call
  mouseDoubleClickEvent(this,param_1);
  return;
}



void __thiscall QQuickWindow::mouseMoveEvent(QQuickWindow *this,QMouseEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010814. Too many branches
                    // WARNING: Treating indirect jump as call
  mouseMoveEvent(this,param_1);
  return;
}



void __thiscall QQuickWindow::mousePressEvent(QQuickWindow *this,QMouseEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x1001081a. Too many branches
                    // WARNING: Treating indirect jump as call
  mousePressEvent(this,param_1);
  return;
}



void __thiscall QQuickWindow::mouseReleaseEvent(QQuickWindow *this,QMouseEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010820. Too many branches
                    // WARNING: Treating indirect jump as call
  mouseReleaseEvent(this,param_1);
  return;
}



int __thiscall
QQuickRenderControl::qt_metacall(QQuickRenderControl *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010826. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



int __thiscall QQuickWindow::qt_metacall(QQuickWindow *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001082c. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



void * __thiscall QQuickRenderControl::qt_metacast(QQuickRenderControl *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010832. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



void * __thiscall QQuickWindow::qt_metacast(QQuickWindow *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010838. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



QWindow * __thiscall QQuickRenderControl::renderWindow(QQuickRenderControl *this,QPoint *param_1)

{
  QWindow *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001083e. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = renderWindow(this,param_1);
  return pQVar1;
}



void __thiscall QQuickWindow::resizeEvent(QQuickWindow *this,QResizeEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010844. Too many branches
                    // WARNING: Treating indirect jump as call
  resizeEvent(this,param_1);
  return;
}



void __thiscall QQuickWindow::showEvent(QQuickWindow *this,QShowEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x1001084a. Too many branches
                    // WARNING: Treating indirect jump as call
  showEvent(this,param_1);
  return;
}



void __thiscall QQuickWindow::wheelEvent(QQuickWindow *this,QWheelEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010850. Too many branches
                    // WARNING: Treating indirect jump as call
  wheelEvent(this,param_1);
  return;
}



void __thiscall QQuickImageProvider::flags(QQuickImageProvider *this)

{
                    // WARNING: Could not recover jumptable at 0x10010856. Too many branches
                    // WARNING: Treating indirect jump as call
  flags(this);
  return;
}



ImageType __thiscall QQuickImageProvider::imageType(QQuickImageProvider *this)

{
  ImageType IVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001085c. Too many branches
                    // WARNING: Treating indirect jump as call
  IVar1 = imageType(this);
  return IVar1;
}



QQuickTextureFactory * __thiscall
QQuickImageProvider::requestTexture
          (QQuickImageProvider *this,QString *param_1,QSize *param_2,QSize *param_3)

{
  QQuickTextureFactory *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010862. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = requestTexture(this,param_1,param_2,param_3);
  return pQVar1;
}



bool __thiscall QOpenGLShaderProgram::link(QOpenGLShaderProgram *this)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010868. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = link(this);
  return bVar1;
}



QMetaObject * __thiscall QOpenGLShaderProgram::metaObject(QOpenGLShaderProgram *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001086e. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



int __thiscall
QOpenGLShaderProgram::qt_metacall
          (QOpenGLShaderProgram *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010874. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



void * __thiscall QOpenGLShaderProgram::qt_metacast(QOpenGLShaderProgram *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001087a. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



bool __thiscall
QGuiApplication::compressEvent
          (QGuiApplication *this,QEvent *param_1,QObject *param_2,QPostEventList *param_3)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010880. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = compressEvent(this,param_1,param_2,param_3);
  return bVar1;
}



bool __thiscall QGuiApplication::event(QGuiApplication *this,QEvent *param_1)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010886. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = event(this,param_1);
  return bVar1;
}



void __thiscall QOffscreenSurface::format(QOffscreenSurface *this)

{
                    // WARNING: Could not recover jumptable at 0x1001088c. Too many branches
                    // WARNING: Treating indirect jump as call
  format(this);
  return;
}



void __thiscall QWindow::format(QWindow *this)

{
                    // WARNING: Could not recover jumptable at 0x10010892. Too many branches
                    // WARNING: Treating indirect jump as call
  format(this);
  return;
}



QMetaObject * __thiscall QGuiApplication::metaObject(QGuiApplication *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010898. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



QMetaObject * __thiscall QOffscreenSurface::metaObject(QOffscreenSurface *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001089e. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



QMetaObject * __thiscall QOpenGLContext::metaObject(QOpenGLContext *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108a4. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



void __thiscall QWindow::moveEvent(QWindow *this,QMoveEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x100108aa. Too many branches
                    // WARNING: Treating indirect jump as call
  moveEvent(this,param_1);
  return;
}



bool __thiscall QWindow::nativeEvent(QWindow *this,QByteArray *param_1,void *param_2,long *param_3)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108b0. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = nativeEvent(this,param_1,param_2,param_3);
  return bVar1;
}



bool __thiscall QGuiApplication::notify(QGuiApplication *this,QObject *param_1,QEvent *param_2)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108b6. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = notify(this,param_1,param_2);
  return bVar1;
}



int __thiscall
QGuiApplication::qt_metacall(QGuiApplication *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108bc. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



int __thiscall
QOffscreenSurface::qt_metacall(QOffscreenSurface *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108c2. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



int __thiscall
QOpenGLContext::qt_metacall(QOpenGLContext *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108c8. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



void * __thiscall QGuiApplication::qt_metacast(QGuiApplication *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108ce. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



void * __thiscall QOffscreenSurface::qt_metacast(QOffscreenSurface *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108d4. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



void * __thiscall QOpenGLContext::qt_metacast(QOpenGLContext *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108da. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



void __thiscall QOffscreenSurface::size(QOffscreenSurface *this)

{
                    // WARNING: Could not recover jumptable at 0x100108e0. Too many branches
                    // WARNING: Treating indirect jump as call
  size(this);
  return;
}



void __thiscall QWindow::size(QWindow *this)

{
                    // WARNING: Could not recover jumptable at 0x100108e6. Too many branches
                    // WARNING: Treating indirect jump as call
  size(this);
  return;
}



QPlatformSurface * __thiscall QOffscreenSurface::surfaceHandle(QOffscreenSurface *this)

{
  QPlatformSurface *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108ec. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = surfaceHandle(this);
  return pQVar1;
}



QPlatformSurface * __thiscall QWindow::surfaceHandle(QWindow *this)

{
  QPlatformSurface *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108f2. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = surfaceHandle(this);
  return pQVar1;
}



SurfaceType __thiscall QOffscreenSurface::surfaceType(QOffscreenSurface *this)

{
  SurfaceType SVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108f8. Too many branches
                    // WARNING: Treating indirect jump as call
  SVar1 = surfaceType(this);
  return SVar1;
}



SurfaceType __thiscall QWindow::surfaceType(QWindow *this)

{
  SurfaceType SVar1;
  
                    // WARNING: Could not recover jumptable at 0x100108fe. Too many branches
                    // WARNING: Treating indirect jump as call
  SVar1 = surfaceType(this);
  return SVar1;
}



void __thiscall QWindow::tabletEvent(QWindow *this,QTabletEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010904. Too many branches
                    // WARNING: Treating indirect jump as call
  tabletEvent(this,param_1);
  return;
}



void __thiscall QWindow::touchEvent(QWindow *this,QTouchEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x1001090a. Too many branches
                    // WARNING: Treating indirect jump as call
  touchEvent(this,param_1);
  return;
}



QObject * __thiscall QQmlComponent::beginCreate(QQmlComponent *this,QQmlContext *param_1)

{
  QObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010910. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = beginCreate(this,param_1);
  return pQVar1;
}



void __thiscall QQmlComponent::completeCreate(QQmlComponent *this)

{
                    // WARNING: Could not recover jumptable at 0x10010916. Too many branches
                    // WARNING: Treating indirect jump as call
  completeCreate(this);
  return;
}



QObject * __thiscall QQmlComponent::create(QQmlComponent *this,QQmlContext *param_1)

{
  QObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001091c. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = create(this,param_1);
  return pQVar1;
}



bool __thiscall QQmlEngine::event(QQmlEngine *this,QEvent *param_1)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010922. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = event(this,param_1);
  return bVar1;
}



QMetaObject * __thiscall QQmlComponent::metaObject(QQmlComponent *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010928. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



QMetaObject * __thiscall QQmlEngine::metaObject(QQmlEngine *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001092e. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



int __thiscall
QQmlComponent::qt_metacall(QQmlComponent *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010934. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



int __thiscall QQmlEngine::qt_metacall(QQmlEngine *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001093a. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



void * __thiscall QQmlComponent::qt_metacast(QQmlComponent *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010940. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



void * __thiscall QQmlEngine::qt_metacast(QQmlEngine *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010946. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



void __thiscall QNetworkReply::ignoreSslErrors(QNetworkReply *this)

{
                    // WARNING: Could not recover jumptable at 0x1001094c. Too many branches
                    // WARNING: Treating indirect jump as call
  ignoreSslErrors(this);
  return;
}



void __thiscall QNetworkReply::ignoreSslErrorsImplementation(QNetworkReply *this,QList<> *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010952. Too many branches
                    // WARNING: Treating indirect jump as call
  ignoreSslErrorsImplementation(this,param_1);
  return;
}



void __thiscall QNetworkReply::setReadBufferSize(QNetworkReply *this,__int64 param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010958. Too many branches
                    // WARNING: Treating indirect jump as call
  setReadBufferSize(this,param_1);
  return;
}



void __thiscall
QNetworkReply::setSslConfigurationImplementation(QNetworkReply *this,QSslConfiguration *param_1)

{
                    // WARNING: Could not recover jumptable at 0x1001095e. Too many branches
                    // WARNING: Treating indirect jump as call
  setSslConfigurationImplementation(this,param_1);
  return;
}



void __thiscall
QNetworkReply::sslConfigurationImplementation(QNetworkReply *this,QSslConfiguration *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010964. Too many branches
                    // WARNING: Treating indirect jump as call
  sslConfigurationImplementation(this,param_1);
  return;
}



__int64 __thiscall QNetworkReply::writeData(QNetworkReply *this,char *param_1,__int64 param_2)

{
  __int64 _Var1;
  
                    // WARNING: Could not recover jumptable at 0x1001096a. Too many branches
                    // WARNING: Treating indirect jump as call
  _Var1 = writeData(this,param_1,param_2);
  return _Var1;
}



bool __thiscall QObject::event(QObject *this,QEvent *param_1)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010970. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = event(this,param_1);
  return bVar1;
}



void __thiscall QObject::childEvent(QObject *this,QChildEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010976. Too many branches
                    // WARNING: Treating indirect jump as call
  childEvent(this,param_1);
  return;
}



void __thiscall QObject::connectNotify(QObject *this,QMetaMethod *param_1)

{
                    // WARNING: Could not recover jumptable at 0x1001097c. Too many branches
                    // WARNING: Treating indirect jump as call
  connectNotify(this,param_1);
  return;
}



void __thiscall QObject::customEvent(QObject *this,QEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010982. Too many branches
                    // WARNING: Treating indirect jump as call
  customEvent(this,param_1);
  return;
}



void __thiscall QObject::disconnectNotify(QObject *this,QMetaMethod *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010988. Too many branches
                    // WARNING: Treating indirect jump as call
  disconnectNotify(this,param_1);
  return;
}



bool __thiscall QObject::eventFilter(QObject *this,QObject *param_1,QEvent *param_2)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001098e. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = eventFilter(this,param_1,param_2);
  return bVar1;
}



void __thiscall QObject::timerEvent(QObject *this,QTimerEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010994. Too many branches
                    // WARNING: Treating indirect jump as call
  timerEvent(this,param_1);
  return;
}



bool __thiscall QThread::event(QThread *this,QEvent *param_1)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001099a. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = event(this,param_1);
  return bVar1;
}



QMetaObject * __thiscall QThread::metaObject(QThread *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109a0. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



QMetaObject * __thiscall QTimer::metaObject(QTimer *this)

{
  QMetaObject *pQVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109a6. Too many branches
                    // WARNING: Treating indirect jump as call
  pQVar1 = metaObject(this);
  return pQVar1;
}



int __thiscall QThread::qt_metacall(QThread *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109ac. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



int __thiscall QTimer::qt_metacall(QTimer *this,Call param_1,int param_2,void **param_3)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109b2. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = qt_metacall(this,param_1,param_2,param_3);
  return iVar1;
}



void * __thiscall QThread::qt_metacast(QThread *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109b8. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



void * __thiscall QTimer::qt_metacast(QTimer *this,char *param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109be. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = qt_metacast(this,param_1);
  return pvVar1;
}



void __thiscall QThread::run(QThread *this)

{
                    // WARNING: Could not recover jumptable at 0x100109c4. Too many branches
                    // WARNING: Treating indirect jump as call
  run(this);
  return;
}



void __thiscall QTimer::timerEvent(QTimer *this,QTimerEvent *param_1)

{
                    // WARNING: Could not recover jumptable at 0x100109ca. Too many branches
                    // WARNING: Treating indirect jump as call
  timerEvent(this,param_1);
  return;
}



int __cdecl QIODevice::open(char *_Filename,int _OpenFlag,...)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109d0. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = open(_Filename,_OpenFlag);
  return iVar1;
}



bool __thiscall QIODevice::atEnd(QIODevice *this)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109d6. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = atEnd(this);
  return bVar1;
}



__int64 __thiscall QIODevice::bytesToWrite(QIODevice *this)

{
  __int64 _Var1;
  
                    // WARNING: Could not recover jumptable at 0x100109dc. Too many branches
                    // WARNING: Treating indirect jump as call
  _Var1 = bytesToWrite(this);
  return _Var1;
}



bool __thiscall QIODevice::canReadLine(QIODevice *this)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109e2. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = canReadLine(this);
  return bVar1;
}



__int64 __thiscall QIODevice::pos(QIODevice *this)

{
  __int64 _Var1;
  
                    // WARNING: Could not recover jumptable at 0x100109e8. Too many branches
                    // WARNING: Treating indirect jump as call
  _Var1 = pos(this);
  return _Var1;
}



__int64 __thiscall QIODevice::readLineData(QIODevice *this,char *param_1,__int64 param_2)

{
  __int64 _Var1;
  
                    // WARNING: Could not recover jumptable at 0x100109ee. Too many branches
                    // WARNING: Treating indirect jump as call
  _Var1 = readLineData(this,param_1,param_2);
  return _Var1;
}



bool __thiscall QIODevice::reset(QIODevice *this)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109f4. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = reset(this);
  return bVar1;
}



bool __thiscall QIODevice::seek(QIODevice *this,__int64 param_1)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x100109fa. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = seek(this,param_1);
  return bVar1;
}



bool __thiscall QIODevice::waitForBytesWritten(QIODevice *this,int param_1)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010a00. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = waitForBytesWritten(this,param_1);
  return bVar1;
}



bool __thiscall QIODevice::waitForReadyRead(QIODevice *this,int param_1)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010a06. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = waitForReadyRead(this,param_1);
  return bVar1;
}



bool __cdecl qRegisterResourceData(int param_1,uchar *param_2,uchar *param_3,uchar *param_4)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010a0c. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = qRegisterResourceData(param_1,param_2,param_3,param_4);
  return bVar1;
}



bool __cdecl qUnregisterResourceData(int param_1,uchar *param_2,uchar *param_3,uchar *param_4)

{
  bool bVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010a12. Too many branches
                    // WARNING: Treating indirect jump as call
  bVar1 = qUnregisterResourceData(param_1,param_2,param_3,param_4);
  return bVar1;
}



void __cdecl FUN_10010a18(uint param_1)

{
  operator_new(param_1);
  return;
}



void __cdecl purecall(void)

{
                    // WARNING: Could not recover jumptable at 0x10010a22. Too many branches
                    // WARNING: Treating indirect jump as call
  purecall();
  return;
}



void * __cdecl operator_new(uint param_1)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010a28. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = operator_new(param_1);
  return pvVar1;
}



void __cdecl operator_delete(void *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010a2e. Too many branches
                    // WARNING: Treating indirect jump as call
  operator_delete(param_1);
  return;
}



// WARNING: Function: __SEH_prolog4 replaced with injection: SEH_prolog4
// WARNING: Function: __SEH_epilog4 replaced with injection: EH_epilog3

_onexit_t __cdecl FUN_10010a70(_onexit_t param_1)

{
  _onexit_t p_Var1;
  PVOID pvVar2;
  PVOID *ppvVar3;
  PVOID *ppvVar4;
  PVOID local_24;
  PVOID local_20 [5];
  undefined4 uStack_c;
  undefined *local_8;
  
  local_8 = &DAT_1001bf80;
  uStack_c = 0x10010a7c;
  local_20[0] = DecodePointer(Ptr_10022950);
  if (local_20[0] == (PVOID)0xffffffff) {
    p_Var1 = _onexit(param_1);
  }
  else {
    _lock(8);
    local_8 = (undefined *)0x0;
    local_20[0] = DecodePointer(Ptr_10022950);
    local_24 = DecodePointer(Ptr_1002294c);
    ppvVar4 = &local_24;
    ppvVar3 = local_20;
    pvVar2 = EncodePointer(param_1);
    p_Var1 = (_onexit_t)__dllonexit(pvVar2,ppvVar3,ppvVar4);
    Ptr_10022950 = EncodePointer(local_20[0]);
    Ptr_1002294c = EncodePointer(local_24);
    local_8 = (undefined *)0xfffffffe;
    FUN_10010b10();
  }
  return p_Var1;
}



void FUN_10010b10(void)

{
  _unlock(8);
  return;
}



int __cdecl FUN_10010b19(_onexit_t param_1)

{
  _onexit_t p_Var1;
  
  p_Var1 = FUN_10010a70(param_1);
  return (p_Var1 != (_onexit_t)0x0) - 1;
}



void __fastcall FUN_10010b2e(int param_1)

{
  if (param_1 == DAT_10022088) {
    return;
  }
                    // WARNING: Subroutine does not return
  ___report_gsfailure();
}



void _CxxThrowException(void *pExceptionObject,ThrowInfo *pThrowInfo)

{
                    // WARNING: Could not recover jumptable at 0x10010b3e. Too many branches
                    // WARNING: Subroutine does not return
                    // WARNING: Treating indirect jump as call
  _CxxThrowException(pExceptionObject,pThrowInfo);
  return;
}



void __CxxFrameHandler3(void)

{
                    // WARNING: Could not recover jumptable at 0x10010b44. Too many branches
                    // WARNING: Subroutine does not return
                    // WARNING: Treating indirect jump as call
  __CxxFrameHandler3();
  return;
}



void * __cdecl memcpy(void *_Dst,void *_Src,size_t _Size)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010b4a. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = memcpy(_Dst,_Src,_Size);
  return pvVar1;
}



// Library Function - Multiple Matches With Different Base Names
//  public: virtual void * __thiscall CDaoRelationFieldInfo::`vector deleting destructor'(unsigned
// int)
//  public: virtual void * __thiscall type_info::`vector deleting destructor'(unsigned int)
// 
// Library: Visual Studio 2012 Release

int * __thiscall FID_conflict__vector_deleting_destructor_(void *this,byte param_1)

{
  int *piVar1;
  
  if ((param_1 & 2) == 0) {
    type_info::~type_info((type_info *)this);
    piVar1 = (int *)this;
    if ((param_1 & 1) != 0) {
      operator_delete(this);
    }
  }
  else {
    piVar1 = (int *)((int)this + -4);
    _eh_vector_destructor_iterator_(this,0xc,*piVar1,type_info::~type_info);
    if ((param_1 & 1) != 0) {
      operator_delete(piVar1);
    }
  }
  return piVar1;
}



double __cdecl ceil(double _X)

{
  double dVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010ba0. Too many branches
                    // WARNING: Treating indirect jump as call
  dVar1 = ceil(_X);
  return dVar1;
}



void __cdecl operator_delete__(void *param_1)

{
                    // WARNING: Could not recover jumptable at 0x10010ba6. Too many branches
                    // WARNING: Treating indirect jump as call
  operator_delete__(param_1);
  return;
}



// WARNING: This is an inlined function

void __alloca_probe(void)

{
  undefined1 *in_EAX;
  undefined4 *puVar1;
  undefined4 *puVar2;
  undefined4 unaff_retaddr;
  undefined1 auStack_4 [4];
  
  puVar2 = (undefined4 *)((int)&stack0x00000000 - (int)in_EAX & ~-(uint)(&stack0x00000000 < in_EAX))
  ;
  for (puVar1 = (undefined4 *)((uint)auStack_4 & 0xfffff000); puVar2 < puVar1;
      puVar1 = puVar1 + -0x400) {
  }
  *puVar2 = unaff_retaddr;
  return;
}



void * __cdecl memset(void *_Dst,int _Val,size_t _Size)

{
  void *pvVar1;
  
                    // WARNING: Could not recover jumptable at 0x10010bdc. Too many branches
                    // WARNING: Treating indirect jump as call
  pvVar1 = memset(_Dst,_Val,_Size);
  return pvVar1;
}



undefined4 FUN_10010c2e(int *param_1,int *param_2,int *param_3)

{
  bool bVar1;
  void *pvVar2;
  void *pvVar3;
  int *_Memory;
  int *piVar4;
  PVOID pvVar5;
  code *pcVar6;
  int *piVar7;
  int *piVar8;
  int iVar9;
  BOOL BVar10;
  
  if (param_2 == (int *)0x0) {
    if (DAT_10022614 < 1) {
      return 0;
    }
    DAT_10022614 = DAT_10022614 + -1;
    bVar1 = false;
    do {
      pvVar3 = (void *)0x0;
      LOCK();
      pvVar2 = StackBase;
      if (DAT_10022940 != (void *)0x0) {
        pvVar3 = DAT_10022940;
        pvVar2 = DAT_10022940;
      }
      DAT_10022940 = pvVar2;
      UNLOCK();
      if (pvVar3 == (void *)0x0) goto LAB_10010c81;
    } while (pvVar3 != StackBase);
    bVar1 = true;
LAB_10010c81:
    if (DAT_10022944 == 2) {
      _Memory = (int *)DecodePointer(Ptr_10022950);
      if (_Memory != (int *)0x0) {
        piVar4 = (int *)DecodePointer(Ptr_1002294c);
        param_1 = piVar4;
        param_2 = _Memory;
        param_3 = _Memory;
        while (piVar4 = piVar4 + -1, _Memory <= piVar4) {
          if ((*piVar4 != 0) && (pvVar5 = EncodePointer((PVOID)0x0), (PVOID)*piVar4 != pvVar5)) {
            pcVar6 = (code *)DecodePointer((PVOID)*piVar4);
            pvVar5 = EncodePointer((PVOID)0x0);
            *piVar4 = (int)pvVar5;
            (*pcVar6)();
            piVar7 = (int *)DecodePointer(Ptr_10022950);
            piVar8 = (int *)DecodePointer(Ptr_1002294c);
            if ((param_2 != piVar7) || (_Memory = param_3, param_1 != piVar8)) {
              piVar4 = piVar8;
              _Memory = piVar7;
              param_1 = piVar8;
              param_2 = piVar7;
              param_3 = piVar7;
            }
          }
        }
        if (_Memory != (int *)0xffffffff) {
          free(_Memory);
        }
        Ptr_1002294c = EncodePointer((PVOID)0x0);
        Ptr_10022950 = Ptr_1002294c;
      }
      DAT_10022944 = 0;
      if (!bVar1) {
        LOCK();
        DAT_10022940 = (void *)0x0;
        UNLOCK();
      }
    }
    else {
      _amsg_exit(0x1f);
    }
  }
  else if (param_2 == (int *)0x1) {
    bVar1 = false;
    do {
      pvVar3 = (void *)0x0;
      LOCK();
      pvVar2 = StackBase;
      if (DAT_10022940 != (void *)0x0) {
        pvVar3 = DAT_10022940;
        pvVar2 = DAT_10022940;
      }
      DAT_10022940 = pvVar2;
      UNLOCK();
      if (pvVar3 == (void *)0x0) goto LAB_10010d9c;
    } while (pvVar3 != StackBase);
    bVar1 = true;
LAB_10010d9c:
    if (DAT_10022944 == 0) {
      DAT_10022944 = 1;
      iVar9 = initterm_e(&DAT_10014798,&DAT_100147a4);
      if (iVar9 != 0) {
        return 0;
      }
      initterm(&DAT_10014768,&DAT_10014794);
      DAT_10022944 = 2;
    }
    else {
      _amsg_exit(0x1f);
    }
    if (!bVar1) {
      LOCK();
      DAT_10022940 = (void *)0x0;
      UNLOCK();
    }
    if ((DAT_10022948 != (code *)0x0) &&
       (BVar10 = __IsNonwritableInCurrentImage((PBYTE)&DAT_10022948), BVar10 != 0)) {
      (*DAT_10022948)(param_1,2,param_3);
    }
    DAT_10022614 = DAT_10022614 + 1;
  }
  return 1;
}



void entry(HMODULE param_1,int *param_2,int *param_3)

{
  if (param_2 == (int *)0x1) {
    ___security_init_cookie();
  }
  ___DllMainCRTStartup(param_1,param_2,param_3);
  return;
}



// WARNING: Function: __SEH_prolog4 replaced with injection: SEH_prolog4
// WARNING: Function: __SEH_epilog4 replaced with injection: EH_epilog3
// WARNING: Removing unreachable block (ram,0x10010ef9)
// WARNING: Removing unreachable block (ram,0x10010e8f)
// WARNING: Removing unreachable block (ram,0x10010f2b)
// WARNING: Globals starting with '_' overlap smaller symbols at the same address
// Library Function - Single Match
//  ___DllMainCRTStartup
// 
// Library: Visual Studio 2012 Release

uint __cdecl ___DllMainCRTStartup(HMODULE param_1,int *param_2,int *param_3)

{
  uint uVar1;
  int iVar2;
  
  _DAT_10022090 = param_2;
  if ((param_2 == (int *)0x0) && (DAT_10022614 == 0)) {
    uVar1 = 0;
  }
  else if (((param_2 != (int *)0x1) && (param_2 != (int *)0x2)) ||
          (uVar1 = FUN_10010c2e(&param_1->unused,param_2,param_3), uVar1 != 0)) {
    uVar1 = _DllMain_12(param_1,(int)param_2);
    if ((param_2 == (int *)0x1) && (uVar1 == 0)) {
      _DllMain_12(param_1,0);
      FUN_10010c2e(&param_1->unused,(int *)0x0,param_3);
    }
    if ((param_2 == (int *)0x0) || (param_2 == (int *)0x3)) {
      iVar2 = FUN_10010c2e(&param_1->unused,param_2,param_3);
      uVar1 = uVar1 & -(uint)(iVar2 != 0);
    }
  }
  FUN_10010f70();
  return uVar1;
}



// WARNING: Globals starting with '_' overlap smaller symbols at the same address

void FUN_10010f70(void)

{
  _DAT_10022090 = 0xffffffff;
  return;
}



void __cdecl _lock(int _File)

{
                    // WARNING: Could not recover jumptable at 0x10010f7c. Too many branches
                    // WARNING: Treating indirect jump as call
  _lock(_File);
  return;
}



void __cdecl _unlock(int _File)

{
                    // WARNING: Could not recover jumptable at 0x10010f82. Too many branches
                    // WARNING: Treating indirect jump as call
  _unlock(_File);
  return;
}



void __dllonexit(void)

{
                    // WARNING: Could not recover jumptable at 0x10010f88. Too many branches
                    // WARNING: Treating indirect jump as call
  __dllonexit();
  return;
}



// WARNING: This is an inlined function
// WARNING: Unable to track spacebase fully for stack
// WARNING: Variable defined which should be unmapped: param_2
// Library Function - Single Match
//  __SEH_prolog4
// 
// Library: Visual Studio

void __cdecl __SEH_prolog4(undefined4 param_1,int param_2)

{
  int iVar1;
  undefined4 unaff_EBX;
  undefined4 unaff_ESI;
  undefined4 unaff_EDI;
  undefined4 unaff_retaddr;
  uint auStack_1c [5];
  undefined1 local_8 [8];
  
  iVar1 = -param_2;
  *(undefined4 *)((int)auStack_1c + iVar1 + 0x10) = unaff_EBX;
  *(undefined4 *)((int)auStack_1c + iVar1 + 0xc) = unaff_ESI;
  *(undefined4 *)((int)auStack_1c + iVar1 + 8) = unaff_EDI;
  *(uint *)((int)auStack_1c + iVar1 + 4) = DAT_10022088 ^ (uint)&param_2;
  *(undefined4 *)((int)auStack_1c + iVar1) = unaff_retaddr;
  ExceptionList = local_8;
  return;
}



// WARNING: This is an inlined function
// Library Function - Single Match
//  __SEH_epilog4
// 
// Library: Visual Studio

void __SEH_epilog4(void)

{
  undefined4 *unaff_EBP;
  undefined4 unaff_retaddr;
  
  ExceptionList = (void *)unaff_EBP[-4];
  *unaff_EBP = unaff_retaddr;
  return;
}



void __cdecl
FUN_10010feb(undefined4 param_1,undefined4 param_2,undefined4 param_3,undefined4 param_4)

{
  except_handler4_common(&DAT_10022088,FUN_10010b2e,param_1,param_2,param_3,param_4);
  return;
}



// Library Function - Single Match
//  ___raise_securityfailure
// 
// Library: Visual Studio 2012 Release

void __cdecl ___raise_securityfailure(EXCEPTION_POINTERS *param_1)

{
  DAT_10022934 = IsDebuggerPresent();
  _crt_debugger_hook(1);
  __crtUnhandledException(param_1);
  if (DAT_10022934 == 0) {
    _crt_debugger_hook(1);
  }
  __crtTerminateProcess(0xc0000409);
  return;
}



// WARNING: Globals starting with '_' overlap smaller symbols at the same address
// Library Function - Single Match
//  ___report_gsfailure
// 
// Library: Visual Studio 2015 Release

void __cdecl ___report_gsfailure(void)

{
  code *pcVar1;
  uint uVar2;
  undefined4 extraout_ECX;
  undefined4 extraout_ECX_00;
  undefined4 uVar3;
  undefined4 extraout_EDX;
  undefined4 unaff_EBX;
  undefined4 unaff_EBP;
  undefined4 unaff_ESI;
  undefined4 unaff_EDI;
  undefined2 in_ES;
  undefined2 in_CS;
  undefined2 in_SS;
  undefined2 in_DS;
  undefined2 in_FS;
  undefined2 in_GS;
  byte bVar4;
  byte bVar5;
  byte in_AF;
  byte bVar6;
  byte bVar7;
  byte in_TF;
  byte in_IF;
  byte bVar8;
  byte in_NT;
  byte in_AC;
  byte in_VIF;
  byte in_VIP;
  byte in_ID;
  undefined8 uVar9;
  undefined4 unaff_retaddr;
  
  uVar2 = IsProcessorFeaturePresent(0x17);
  uVar9 = CONCAT44(extraout_EDX,uVar2);
  bVar4 = 0;
  bVar8 = 0;
  bVar7 = (int)uVar2 < 0;
  bVar6 = uVar2 == 0;
  bVar5 = (POPCOUNT(uVar2 & 0xff) & 1U) == 0;
  uVar3 = extraout_ECX;
  if (!(bool)bVar6) {
    pcVar1 = (code *)swi(0x29);
    uVar9 = (*pcVar1)();
    uVar3 = extraout_ECX_00;
  }
  _DAT_10022710 = (undefined4)((ulonglong)uVar9 >> 0x20);
  _DAT_10022718 = (undefined4)uVar9;
  _DAT_10022728 =
       (uint)(in_NT & 1) * 0x4000 | (uint)(bVar8 & 1) * 0x800 | (uint)(in_IF & 1) * 0x200 |
       (uint)(in_TF & 1) * 0x100 | (uint)(bVar7 & 1) * 0x80 | (uint)(bVar6 & 1) * 0x40 |
       (uint)(in_AF & 1) * 0x10 | (uint)(bVar5 & 1) * 4 | (uint)(bVar4 & 1) |
       (uint)(in_ID & 1) * 0x200000 | (uint)(in_VIP & 1) * 0x100000 | (uint)(in_VIF & 1) * 0x80000 |
       (uint)(in_AC & 1) * 0x40000;
  _DAT_1002272c = &stack0x00000004;
  _DAT_10022668 = 0x10001;
  _DAT_10022618 = 0xc0000409;
  _DAT_1002261c = 1;
  _DAT_10022628 = 1;
  DAT_1002262c = 2;
  _DAT_10022624 = unaff_retaddr;
  _DAT_100226f4 = in_GS;
  _DAT_100226f8 = in_FS;
  _DAT_100226fc = in_ES;
  _DAT_10022700 = in_DS;
  _DAT_10022704 = unaff_EDI;
  _DAT_10022708 = unaff_ESI;
  _DAT_1002270c = unaff_EBX;
  _DAT_10022714 = uVar3;
  _DAT_1002271c = unaff_EBP;
  DAT_10022720 = unaff_retaddr;
  _DAT_10022724 = in_CS;
  _DAT_10022730 = in_SS;
  ___raise_securityfailure((EXCEPTION_POINTERS *)&PTR_DAT_10019708);
  return;
}



// WARNING: Function: __SEH_prolog4 replaced with injection: SEH_prolog4
// WARNING: Function: __SEH_epilog4 replaced with injection: EH_epilog3
// Library Function - Single Match
//  void __stdcall `eh vector destructor iterator'(void *,unsigned int,int,void (__thiscall*)(void
// *))
// 
// Library: Visual Studio 2012 Release

void _eh_vector_destructor_iterator_
               (void *param_1,uint param_2,int param_3,_func_void_void_ptr *param_4)

{
  void *in_stack_ffffffd0;
  
  while( true ) {
    param_3 = param_3 + -1;
    if (param_3 < 0) break;
    (*param_4)(in_stack_ffffffd0);
  }
  FUN_100111a5();
  return;
}



void FUN_100111a5(void)

{
  int in_EAX;
  uint unaff_EBX;
  int unaff_EBP;
  void *unaff_ESI;
  int unaff_EDI;
  
  if (in_EAX == 0) {
    __ArrayUnwind(unaff_ESI,unaff_EBX,unaff_EDI,*(_func_void_void_ptr **)(unaff_EBP + 0x14));
  }
  return;
}



// WARNING: Function: __SEH_prolog4 replaced with injection: SEH_prolog4
// WARNING: Function: __SEH_epilog4 replaced with injection: EH_epilog3
// Library Function - Single Match
//  void __stdcall __ArrayUnwind(void *,unsigned int,int,void (__thiscall*)(void *))
// 
// Library: Visual Studio 2012 Release

void __ArrayUnwind(void *param_1,uint param_2,int param_3,_func_void_void_ptr *param_4)

{
  void *in_stack_ffffffc8;
  
  while( true ) {
    param_3 = param_3 + -1;
    if (param_3 < 0) break;
    (*param_4)(in_stack_ffffffc8);
  }
  return;
}



void __thiscall type_info::~type_info(type_info *this)

{
                    // WARNING: Could not recover jumptable at 0x10011214. Too many branches
                    // WARNING: Treating indirect jump as call
  ~type_info(this);
  return;
}



int __cdecl __CppXcptFilter(ulong _ExceptionNum,_EXCEPTION_POINTERS *_ExceptionPtr)

{
  int iVar1;
  
                    // WARNING: Could not recover jumptable at 0x1001121a. Too many branches
                    // WARNING: Treating indirect jump as call
  iVar1 = __CppXcptFilter(_ExceptionNum,_ExceptionPtr);
  return iVar1;
}



void __cdecl _amsg_exit(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x10011220. Too many branches
                    // WARNING: Treating indirect jump as call
  _amsg_exit(param_1);
  return;
}



// Library Function - Single Match
//  __FindPESection
// 
// Libraries: Visual Studio 2015 Release, Visual Studio 2017 Release, Visual Studio 2019 Release

PIMAGE_SECTION_HEADER __cdecl __FindPESection(PBYTE pImageBase,DWORD_PTR rva)

{
  int iVar1;
  PIMAGE_SECTION_HEADER p_Var2;
  uint uVar3;
  
  uVar3 = 0;
  iVar1 = *(int *)(pImageBase + 0x3c);
  p_Var2 = (PIMAGE_SECTION_HEADER)
           (pImageBase + *(ushort *)(pImageBase + iVar1 + 0x14) + 0x18 + iVar1);
  if (*(ushort *)(pImageBase + iVar1 + 6) != 0) {
    do {
      if ((p_Var2->VirtualAddress <= rva) &&
         (rva < (p_Var2->Misc).PhysicalAddress + p_Var2->VirtualAddress)) {
        return p_Var2;
      }
      uVar3 = uVar3 + 1;
      p_Var2 = p_Var2 + 1;
    } while (uVar3 < *(ushort *)(pImageBase + iVar1 + 6));
  }
  return (PIMAGE_SECTION_HEADER)0x0;
}



// Library Function - Single Match
//  __IsNonwritableInCurrentImage
// 
// Libraries: Visual Studio 2015 Release, Visual Studio 2019 Release

BOOL __cdecl __IsNonwritableInCurrentImage(PBYTE pTarget)

{
  BOOL BVar1;
  PIMAGE_SECTION_HEADER p_Var2;
  void *local_14;
  code *pcStack_10;
  uint local_c;
  undefined4 local_8;
  
  pcStack_10 = FUN_10010feb;
  local_14 = ExceptionList;
  local_c = DAT_10022088 ^ 0x1001c008;
  ExceptionList = &local_14;
  local_8 = 0;
  BVar1 = __ValidateImageBase((PBYTE)&IMAGE_DOS_HEADER_10000000);
  if (BVar1 != 0) {
    p_Var2 = __FindPESection((PBYTE)&IMAGE_DOS_HEADER_10000000,(DWORD_PTR)(pTarget + -0x10000000));
    if (p_Var2 != (PIMAGE_SECTION_HEADER)0x0) {
      ExceptionList = local_14;
      return ~(p_Var2->Characteristics >> 0x1f) & 1;
    }
  }
  ExceptionList = local_14;
  return 0;
}



// Library Function - Single Match
//  __ValidateImageBase
// 
// Libraries: Visual Studio 2012 Release, Visual Studio 2015 Release

BOOL __cdecl __ValidateImageBase(PBYTE pImageBase)

{
  uint uVar1;
  
  if (*(short *)pImageBase != 0x5a4d) {
    return 0;
  }
  uVar1 = 0;
  if (*(int *)(pImageBase + *(int *)(pImageBase + 0x3c)) == 0x4550) {
    uVar1 = (uint)((short)*(int *)((int)(pImageBase + *(int *)(pImageBase + 0x3c)) + 0x18) == 0x10b)
    ;
  }
  return uVar1;
}



// Library Function - Single Match
//  ___security_init_cookie
// 
// Library: Visual Studio 2015 Release

void __cdecl ___security_init_cookie(void)

{
  DWORD DVar1;
  LARGE_INTEGER local_18;
  _FILETIME local_10;
  uint local_8;
  
  local_10.dwLowDateTime = 0;
  local_10.dwHighDateTime = 0;
  if ((DAT_10022088 == 0xbb40e64e) || ((DAT_10022088 & 0xffff0000) == 0)) {
    GetSystemTimeAsFileTime(&local_10);
    local_8 = local_10.dwHighDateTime ^ local_10.dwLowDateTime;
    DVar1 = GetCurrentThreadId();
    local_8 = local_8 ^ DVar1;
    DVar1 = GetCurrentProcessId();
    local_8 = local_8 ^ DVar1;
    QueryPerformanceCounter(&local_18);
    DAT_10022088 = local_18.s.HighPart ^ local_18.s.LowPart ^ local_8 ^ (uint)&local_8;
    if (DAT_10022088 == 0xbb40e64e) {
      DAT_10022088 = 0xbb40e64f;
    }
    else if ((DAT_10022088 & 0xffff0000) == 0) {
      DAT_10022088 = DAT_10022088 | (DAT_10022088 | 0x4711) << 0x10;
    }
    DAT_1002208c = ~DAT_10022088;
  }
  else {
    DAT_1002208c = ~DAT_10022088;
  }
  return;
}



// Library Function - Single Match
//  _DllMain@12
// 
// Library: Visual Studio 2012 Release

undefined4 _DllMain_12(HMODULE param_1,int param_2)

{
  if (param_2 == 1) {
    DisableThreadLibraryCalls(param_1);
  }
  return 1;
}



void __cdecl initterm(void)

{
                    // WARNING: Could not recover jumptable at 0x10011470. Too many branches
                    // WARNING: Treating indirect jump as call
  initterm();
  return;
}



void __cdecl initterm_e(void)

{
                    // WARNING: Could not recover jumptable at 0x10011476. Too many branches
                    // WARNING: Treating indirect jump as call
  initterm_e();
  return;
}



void __cdecl except_handler4_common(void)

{
                    // WARNING: Could not recover jumptable at 0x10011488. Too many branches
                    // WARNING: Treating indirect jump as call
  except_handler4_common();
  return;
}



void __cdecl _crt_debugger_hook(int param_1)

{
                    // WARNING: Could not recover jumptable at 0x1001148e. Too many branches
                    // WARNING: Treating indirect jump as call
  _crt_debugger_hook(param_1);
  return;
}



LONG __cdecl __crtUnhandledException(EXCEPTION_POINTERS *exceptionInfo)

{
  LONG LVar1;
  
                    // WARNING: Could not recover jumptable at 0x10011494. Too many branches
                    // WARNING: Treating indirect jump as call
  LVar1 = __crtUnhandledException(exceptionInfo);
  return LVar1;
}



void __cdecl __crtTerminateProcess(UINT uExitCode)

{
                    // WARNING: Could not recover jumptable at 0x1001149a. Too many branches
                    // WARNING: Treating indirect jump as call
  __crtTerminateProcess(uExitCode);
  return;
}



void __cdecl terminate(void)

{
                    // WARNING: Could not recover jumptable at 0x100114a0. Too many branches
                    // WARNING: Subroutine does not return
                    // WARNING: Treating indirect jump as call
  terminate();
  return;
}



BOOL IsProcessorFeaturePresent(DWORD ProcessorFeature)

{
  BOOL BVar1;
  
                    // WARNING: Could not recover jumptable at 0x100114ac. Too many branches
                    // WARNING: Treating indirect jump as call
  BVar1 = IsProcessorFeaturePresent(ProcessorFeature);
  return BVar1;
}



void Unwind_100114e0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100114e6. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x88));
  return;
}



void Unwind_100114ec(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100114ef. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x80));
  return;
}



void Unwind_100114f5(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100114fb. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x84));
  return;
}



void Unwind_10011501(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011504. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x74));
  return;
}



void Unwind_1001150a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001150d. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x80));
  return;
}



void Unwind_10011513(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011519. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x88));
  return;
}



void Unwind_1001151f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011522. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x78));
  return;
}



void Unwind_10011528(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001152b. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x74));
  return;
}



void Unwind_10011531(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011534. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x80));
  return;
}



void Unwind_1001153a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011540. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x88));
  return;
}



void Unwind_10011546(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011549. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x78));
  return;
}



void Unwind_1001154f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011552. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x74));
  return;
}



void Unwind_10011558(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001155e. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x88));
  return;
}



void Unwind_10011564(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011567. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x7c));
  return;
}



void Unwind_1001156d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011570. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x80));
  return;
}



void Unwind_10011576(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011579. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x78));
  return;
}



void Unwind_1001157f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011582. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x74));
  return;
}



void Unwind_10011588(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001158b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x6c));
  return;
}



void Unwind_10011591(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011594. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -100));
  return;
}



void Unwind_1001159a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001159d. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x68));
  return;
}



void Unwind_100115a3(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100115a6. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x60));
  return;
}



void Unwind_100115e0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100115e3. Too many branches
                    // WARNING: Treating indirect jump as call
  QMutexLocker::~QMutexLocker((QMutexLocker *)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011610(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011613. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x80));
  return;
}



void Unwind_10011619(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001161c. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x6c));
  return;
}



void Unwind_10011622(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x60));
  return;
}



void Unwind_1001162d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011630. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x80));
  return;
}



void Unwind_10011636(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011639. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x80));
  return;
}



void Unwind_1001163f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011642. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x80));
  return;
}



void Unwind_10011648(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001164b. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x80));
  return;
}



void Unwind_10011680(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 4));
  return;
}



void Unwind_100116b0(void)

{
  DAT_100225e0 = DAT_100225e0 & 0xfffffffe;
  return;
}



void Unwind_100116e0(void)

{
  int unaff_EBP;
  
  FUN_10003540(unaff_EBP + -0x9c);
  return;
}



void Unwind_100116eb(void)

{
  int unaff_EBP;
  
  FUN_10003540(unaff_EBP + -0x5c);
  return;
}



void Unwind_100116f3(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100116f9. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -200));
  return;
}



void Unwind_10011720(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011723. Too many branches
                    // WARNING: Treating indirect jump as call
  QObject::~QObject(*(QObject **)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011729(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001172f. Too many branches
                    // WARNING: Treating indirect jump as call
  QWaitCondition::~QWaitCondition((QWaitCondition *)(*(int *)(unaff_EBP + -0x10) + 8));
  return;
}



void Unwind_10011735(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001173b. Too many branches
                    // WARNING: Treating indirect jump as call
  QMutex::~QMutex((QMutex *)(*(int *)(unaff_EBP + -0x10) + 0xc));
  return;
}



void Unwind_10011741(void)

{
  int unaff_EBP;
  
  FUN_10003500(*(int *)(unaff_EBP + -0x10) + 0x48);
  return;
}



void Unwind_10011770(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011773. Too many branches
                    // WARNING: Treating indirect jump as call
  QObject::~QObject(*(QObject **)(unaff_EBP + -0x10));
  return;
}



void Unwind_100117a0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100117a3. Too many branches
                    // WARNING: Treating indirect jump as call
  QObject::~QObject(*(QObject **)(unaff_EBP + -0x10));
  return;
}



void Unwind_100117a9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100117af. Too many branches
                    // WARNING: Treating indirect jump as call
  QWaitCondition::~QWaitCondition((QWaitCondition *)(*(int *)(unaff_EBP + -0x10) + 8));
  return;
}



void Unwind_100117b5(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100117bb. Too many branches
                    // WARNING: Treating indirect jump as call
  QMutex::~QMutex((QMutex *)(*(int *)(unaff_EBP + -0x10) + 0xc));
  return;
}



void Unwind_100117c1(void)

{
  int unaff_EBP;
  
  FUN_10003500(*(int *)(unaff_EBP + -0x10) + 0x48);
  return;
}



void Unwind_100117f0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100117f3. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011820(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_1001182b(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001182e. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10011834(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011837. Too many branches
                    // WARNING: Treating indirect jump as call
  QSurfaceFormat::~QSurfaceFormat((QSurfaceFormat *)(unaff_EBP + -0x28));
  return;
}



void Unwind_1001183d(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011848(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011853(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011856. Too many branches
                    // WARNING: Treating indirect jump as call
  QSurfaceFormat::~QSurfaceFormat((QSurfaceFormat *)(unaff_EBP + -0x24));
  return;
}



void Unwind_1001185c(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011867(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011872(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_1001187d(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011888(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011893(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011896. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_1001189c(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_100118a7(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_100118b2(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x2c));
  return;
}



void Unwind_100118f0(void)

{
  param_2_10003760();
  return;
}



void Unwind_10011920(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 0xc));
  return;
}



void Unwind_1001192b(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 0xc));
  return;
}



void Unwind_10011936(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011939. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 0xc));
  return;
}



void Unwind_10011960(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011963. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_100119a0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100119a3. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_100119e0(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x10));
  return;
}



void Unwind_100119eb(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x14) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x14) = *(uint *)(unaff_EBP + -0x14) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x100119fe. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString((QString *)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10011a20(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011a2b(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x18) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x18) = *(uint *)(unaff_EBP + -0x18) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x10011a3e. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString((QString *)(unaff_EBP + -0x14));
    return;
  }
  return;
}



void Unwind_10011a45(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x14));
  return;
}



void Unwind_10011a50(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x18) & 2) != 0) {
    *(uint *)(unaff_EBP + -0x18) = *(uint *)(unaff_EBP + -0x18) & 0xfffffffd;
                    // WARNING: Could not recover jumptable at 0x10011a63. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString((QString *)(unaff_EBP + -0x10));
    return;
  }
  return;
}



void Unwind_10011a90(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011a93. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011a99(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011a9c. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 0xc));
  return;
}



void Unwind_10011ac0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011ac3. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011af0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011af3. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011af9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011afc. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011b20(void)

{
  int unaff_EBP;
  
  FUN_100034b0((undefined4 *)(unaff_EBP + -0x28));
  return;
}



void Unwind_10011b28(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b2b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10011b31(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b34. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011b3a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b3d. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011b43(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b46. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10011b4c(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b4f. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011b55(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b58. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011b5e(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b61. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10011b67(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b6a. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011b70(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b73. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011b79(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b7c. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10011b82(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b85. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011b8b(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b8e. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011b94(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011b97. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10011b9d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011ba0. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011ba6(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011ba9. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011baf(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011bb2. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011bb8(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011bbb. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011bc1(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011bc4. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011bca(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011bcd. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011bd3(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011bd6. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011bdc(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011bdf. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011be5(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011be8. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011bee(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011bf1. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011bf7(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011bfa. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011c00(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c03. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011c09(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c0c. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011c12(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c15. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011c1b(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c1e. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011c24(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c27. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011c2d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c30. Too many branches
                    // WARNING: Treating indirect jump as call
  QDateTime::~QDateTime((QDateTime *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10011c36(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c39. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011c3f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c42. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011c48(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c4b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 8));
  return;
}



void Unwind_10011c51(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011c54. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 4));
  return;
}



void Unwind_10011c80(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 4));
  return;
}



void Unwind_10011c8b(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 4));
  return;
}



void Unwind_10011c96(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 4));
  return;
}



void Unwind_10011cc0(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 4));
  return;
}



void Unwind_10011cf0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011cf3. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 8));
  return;
}



void Unwind_10011d20(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011d23. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011d50(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011d53. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x14));
  return;
}



void Unwind_10011d80(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011d83. Too many branches
                    // WARNING: Treating indirect jump as call
  QMutexLocker::~QMutexLocker((QMutexLocker *)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011db0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011db3. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_10011db9(void)

{
  int unaff_EBP;
  
  FUN_10003450((undefined4 *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_10011dc1(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011dc4. Too many branches
                    // WARNING: Treating indirect jump as call
  QUrl::~QUrl((QUrl *)(unaff_EBP + -0x40));
  return;
}



void Unwind_10011dca(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011dcd. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x44));
  return;
}



void Unwind_10011dd3(void)

{
  int unaff_EBP;
  
  FUN_10003450((undefined4 *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_10011ddb(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011dde. Too many branches
                    // WARNING: Treating indirect jump as call
  QUrl::~QUrl((QUrl *)(unaff_EBP + -0x48));
  return;
}



void Unwind_10011de4(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011de7. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x44));
  return;
}



void Unwind_10011ded(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011df0. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x40));
  return;
}



void Unwind_10011e20(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011e2b(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x18) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x18) = *(uint *)(unaff_EBP + -0x18) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x10011e3e. Too many branches
                    // WARNING: Treating indirect jump as call
    QUrl::~QUrl((QUrl *)(unaff_EBP + -0x14));
    return;
  }
  return;
}



void Unwind_10011e60(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011e63. Too many branches
                    // WARNING: Treating indirect jump as call
  QNetworkReply::~QNetworkReply(*(QNetworkReply **)(unaff_EBP + -0x28));
  return;
}



void Unwind_10011e69(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011e6c. Too many branches
                    // WARNING: Treating indirect jump as call
  QUrl::~QUrl((QUrl *)(unaff_EBP + 8));
  return;
}



void Unwind_10011e72(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011e75. Too many branches
                    // WARNING: Treating indirect jump as call
  QUrl::~QUrl((QUrl *)(unaff_EBP + 4));
  return;
}



void Unwind_10011e7b(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011e7e. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x34));
  return;
}



void Unwind_10011e84(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011e87. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + 8));
  return;
}



void Unwind_10011e8d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011e90. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 8));
  return;
}



void Unwind_10011e96(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011e99. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011e9f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011ea2. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011ea8(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011eab. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + 8));
  return;
}



void Unwind_10011eb1(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011eb4. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x20));
  return;
}



void Unwind_10011ee0(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011f10(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011f13. Too many branches
                    // WARNING: Treating indirect jump as call
  QUrl::~QUrl((QUrl *)(unaff_EBP + -0x10));
  return;
}



void Unwind_10011f19(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011f1c. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 8));
  return;
}



void Unwind_10011f22(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 8));
  return;
}



void Unwind_10011f50(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011f53. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011f59(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011f5c. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011f80(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011f83. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10011f89(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011f8c. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10011fb0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011fb3. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x30));
  return;
}



void Unwind_10011fb9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011fbf. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x88));
  return;
}



void Unwind_10011fc5(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011fc8. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x40));
  return;
}



void Unwind_10011fce(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10011fd1. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x58));
  return;
}



void Unwind_10012000(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012003. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10012009(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001200c. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10012030(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012033. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x3c));
  return;
}



void Unwind_10012039(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001203c. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_10012042(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012045. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_1001204b(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001204e. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x3c));
  return;
}



void Unwind_10012054(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012057. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_1001205d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012060. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10012090(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012093. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10012099(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001209c. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_100120c0(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x3c) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x3c) = *(uint *)(unaff_EBP + -0x3c) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x100120d3. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x1c));
    return;
  }
  return;
}



void Unwind_10012100(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10c) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x10c) = *(uint *)(unaff_EBP + -0x10c) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x1001211c. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0xc0));
    return;
  }
  return;
}



void Unwind_10012123(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10c) & 2) != 0) {
    *(uint *)(unaff_EBP + -0x10c) = *(uint *)(unaff_EBP + -0x10c) & 0xfffffffd;
                    // WARNING: Could not recover jumptable at 0x1001213f. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0xd0));
    return;
  }
  return;
}



void Unwind_10012146(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10c) & 4) != 0) {
    *(uint *)(unaff_EBP + -0x10c) = *(uint *)(unaff_EBP + -0x10c) & 0xfffffffb;
                    // WARNING: Could not recover jumptable at 0x10012162. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0xa0));
    return;
  }
  return;
}



void Unwind_10012169(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10c) & 8) != 0) {
    *(uint *)(unaff_EBP + -0x10c) = *(uint *)(unaff_EBP + -0x10c) & 0xfffffff7;
                    // WARNING: Could not recover jumptable at 0x10012185. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0xb0));
    return;
  }
  return;
}



void Unwind_1001218c(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10c) & 0x10) != 0) {
    *(uint *)(unaff_EBP + -0x10c) = *(uint *)(unaff_EBP + -0x10c) & 0xffffffef;
                    // WARNING: Could not recover jumptable at 0x100121a8. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0xd0));
    return;
  }
  return;
}



void Unwind_100121af(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10c) & 0x20) != 0) {
    *(uint *)(unaff_EBP + -0x10c) = *(uint *)(unaff_EBP + -0x10c) & 0xffffffdf;
                    // WARNING: Could not recover jumptable at 0x100121cb. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0xa0));
    return;
  }
  return;
}



void Unwind_100121d2(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10c) & 0x40) != 0) {
    *(uint *)(unaff_EBP + -0x10c) = *(uint *)(unaff_EBP + -0x10c) & 0xffffffbf;
                    // WARNING: Could not recover jumptable at 0x100121ee. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0xb0));
    return;
  }
  return;
}



void Unwind_100121f5(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10c) & 0x80) != 0) {
    *(uint *)(unaff_EBP + -0x10c) = *(uint *)(unaff_EBP + -0x10c) & 0xffffff7f;
                    // WARNING: Could not recover jumptable at 0x10012216. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0xc0));
    return;
  }
  return;
}



void Unwind_1001221d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012220. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x50));
  return;
}



void Unwind_10012226(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001222c. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0xc0));
  return;
}



void Unwind_10012232(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012235. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x80));
  return;
}



void Unwind_1001223b(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001223e. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x30));
  return;
}



void Unwind_10012244(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012247. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x60));
  return;
}



void Unwind_1001224d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012250. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x70));
  return;
}



void Unwind_10012256(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012259. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x20));
  return;
}



void Unwind_1001225f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012262. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x40));
  return;
}



void Unwind_10012290(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012293. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_10012299(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001229c. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_100122a2(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100122a5. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x3c));
  return;
}



void Unwind_100122ab(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100122ae. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_100122d0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100122d3. Too many branches
                    // WARNING: Treating indirect jump as call
  QObject::~QObject(*(QObject **)(unaff_EBP + -0x10));
  return;
}



void Unwind_100122d9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100122df. Too many branches
                    // WARNING: Treating indirect jump as call
  QMutex::~QMutex((QMutex *)(*(int *)(unaff_EBP + -0x10) + 0xc));
  return;
}



void Unwind_100122e5(void)

{
  int unaff_EBP;
  
  FUN_10009460((undefined4 *)(*(int *)(unaff_EBP + -0x10) + 0x10));
  return;
}



void Unwind_100122f0(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 8));
  return;
}



void Unwind_10012320(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012323. Too many branches
                    // WARNING: Treating indirect jump as call
  QObject::~QObject(*(QObject **)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012329(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001232f. Too many branches
                    // WARNING: Treating indirect jump as call
  QMutex::~QMutex((QMutex *)(*(int *)(unaff_EBP + -0x24) + 0xc));
  return;
}



void Unwind_10012335(void)

{
  int unaff_EBP;
  
  FUN_10009460((undefined4 *)(*(int *)(unaff_EBP + -0x24) + 0x10));
  return;
}



void Unwind_10012340(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012343. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x28));
  return;
}



void Unwind_10012370(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012373. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x30));
  return;
}



void Unwind_10012379(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001237c. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonObject::~QJsonObject((QJsonObject *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10012382(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012385. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_100123b0(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x18));
  return;
}



void Unwind_10012420(void)

{
  int unaff_EBP;
  
  FUN_100094c0((undefined4 *)(unaff_EBP + -0x74));
  return;
}



void Unwind_10012428(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x54) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x54) = *(uint *)(unaff_EBP + -0x54) & 0xfffffffe;
    FUN_10009460(*(undefined4 **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012441(void)

{
  int unaff_EBP;
  
  FUN_100034b0((undefined4 *)(unaff_EBP + -0x70));
  return;
}



void Unwind_10012449(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001244c. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -100));
  return;
}



void Unwind_10012452(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012455. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_1001245b(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001245e. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x68));
  return;
}



void Unwind_10012464(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012467. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x5c));
  return;
}



void Unwind_1001246d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012470. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x3c));
  return;
}



void Unwind_10012476(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012479. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x60));
  return;
}



void Unwind_1001247f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012482. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10012488(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001248b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x58));
  return;
}



void Unwind_10012491(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012494. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_100124c0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100124c3. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x10));
  return;
}



void Unwind_100124f0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100124f3. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x14));
  return;
}



void Unwind_10012520(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x9c) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x9c) = *(uint *)(unaff_EBP + -0x9c) & 0xfffffffe;
    FUN_100034b0(*(undefined4 **)(unaff_EBP + -0x98));
    return;
  }
  return;
}



void Unwind_10012542(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012548. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0xac));
  return;
}



void Unwind_1001254e(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012554. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xb0));
  return;
}



void Unwind_1001255a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012560. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0xac));
  return;
}



void Unwind_10012566(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001256c. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xb0));
  return;
}



void Unwind_10012572(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012578. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0xac));
  return;
}



void Unwind_1001257e(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012584. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xb0));
  return;
}



void Unwind_100125c0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100125c3. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x10));
  return;
}



void Unwind_100125c9(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x14) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x14) = *(uint *)(unaff_EBP + -0x14) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x100125dc. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString(*(QString **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012600(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012603. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10012609(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x20) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x20) = *(uint *)(unaff_EBP + -0x20) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x1001261c. Too many branches
                    // WARNING: Treating indirect jump as call
    QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x10));
    return;
  }
  return;
}



void Unwind_10012623(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x20) & 2) != 0) {
    *(uint *)(unaff_EBP + -0x20) = *(uint *)(unaff_EBP + -0x20) & 0xfffffffd;
                    // WARNING: Could not recover jumptable at 0x10012636. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString((QString *)(unaff_EBP + -0x14));
    return;
  }
  return;
}



void Unwind_1001263d(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x20) & 8) != 0) {
    *(uint *)(unaff_EBP + -0x20) = *(uint *)(unaff_EBP + -0x20) & 0xfffffff7;
                    // WARNING: Could not recover jumptable at 0x10012650. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString(*(QString **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012680(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012686. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x401c));
  return;
}



void Unwind_1001268c(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x4018) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x4018) = *(uint *)(unaff_EBP + -0x4018) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x100126a8. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString(*(QString **)(unaff_EBP + -0x4014));
    return;
  }
  return;
}



void Unwind_100126e0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100126e3. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x10));
  return;
}



void Unwind_100126e9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100126ec. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + 8));
  return;
}



void Unwind_10012710(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012713. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x10));
  return;
}



void Unwind_10012719(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x14) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x14) = *(uint *)(unaff_EBP + -0x14) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x1001272c. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString(*(QString **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012750(void)

{
  int unaff_EBP;
  
  FUN_10009490((undefined4 *)(unaff_EBP + -0x118));
  return;
}



void Unwind_1001275b(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -200) & 1) != 0) {
    *(uint *)(unaff_EBP + -200) = *(uint *)(unaff_EBP + -200) & 0xfffffffe;
    FUN_10009460(*(undefined4 **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_1001277a(void)

{
  int unaff_EBP;
  
  FUN_100034b0((undefined4 *)(unaff_EBP + -0x11c));
  return;
}



void Unwind_10012785(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001278b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x114));
  return;
}



void Unwind_10012791(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012797. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xd8));
  return;
}



void Unwind_1001279d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100127a3. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xd4));
  return;
}



void Unwind_100127a9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100127af. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xb0));
  return;
}



void Unwind_100127b5(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100127bb. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x9c));
  return;
}



void Unwind_100127c1(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100127c7. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xdc));
  return;
}



void Unwind_100127cd(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100127d3. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x104));
  return;
}



void Unwind_100127d9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100127df. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xa0));
  return;
}



void Unwind_100127e5(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100127eb. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xc0));
  return;
}



void Unwind_100127f1(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100127f4. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_100127fa(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012800. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xfc));
  return;
}



void Unwind_10012806(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012809. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x6c));
  return;
}



void Unwind_1001280f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012815. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xf4));
  return;
}



void Unwind_1001281b(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001281e. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10012824(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001282a. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xe4));
  return;
}



void Unwind_10012830(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012836. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x8c));
  return;
}



void Unwind_1001283c(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012842. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xec));
  return;
}



void Unwind_10012848(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001284b. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x7c));
  return;
}



void Unwind_10012851(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012857. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x100));
  return;
}



void Unwind_1001285d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012863. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xa4));
  return;
}



void Unwind_10012869(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001286f. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xf0));
  return;
}



void Unwind_10012875(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001287b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xb4));
  return;
}



void Unwind_10012881(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012884. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x5c));
  return;
}



void Unwind_1001288a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012890. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xf8));
  return;
}



void Unwind_10012896(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001289c. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xd0));
  return;
}



void Unwind_100128a2(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100128a8. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xe0));
  return;
}



void Unwind_100128ae(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100128b4. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xb8));
  return;
}



void Unwind_100128ba(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100128bd. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x3c));
  return;
}



void Unwind_100128c3(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100128c9. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xe8));
  return;
}



void Unwind_100128cf(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100128d2. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10012900(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x54) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x54) = *(uint *)(unaff_EBP + -0x54) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x10012913. Too many branches
                    // WARNING: Treating indirect jump as call
    QJsonArray::~QJsonArray(*(QJsonArray **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_1001291a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001291d. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -100));
  return;
}



void Unwind_10012923(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012926. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x68));
  return;
}



void Unwind_1001292c(void)

{
  int unaff_EBP;
  
  FUN_10009640((undefined4 *)(unaff_EBP + -0x78));
  return;
}



void Unwind_10012934(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012937. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x60));
  return;
}



void Unwind_1001293d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012940. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x48));
  return;
}



void Unwind_10012946(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012949. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_1001294f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012952. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x5c));
  return;
}



void Unwind_10012958(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001295b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x74));
  return;
}



void Unwind_10012961(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012964. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x44));
  return;
}



void Unwind_1001296a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001296d. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonDocument::~QJsonDocument((QJsonDocument *)(unaff_EBP + -0x6c));
  return;
}



void Unwind_10012973(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012976. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonObject::~QJsonObject((QJsonObject *)(unaff_EBP + -0x3c));
  return;
}



void Unwind_1001297c(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001297f. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x58));
  return;
}



void Unwind_10012985(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012988. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_1001298e(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012991. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonValue::~QJsonValue((QJsonValue *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_100129c0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100129c3. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x18));
  return;
}



void Unwind_100129c9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x100129cc. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 8));
  return;
}



void Unwind_100129d2(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x14) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x14) = *(uint *)(unaff_EBP + -0x14) & 0xfffffffe;
    FUN_10009640(*(undefined4 **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012a10(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012a13. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x14));
  return;
}



void Unwind_10012a19(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012a1c. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x18));
  return;
}



void Unwind_10012a22(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012a25. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 0xc));
  return;
}



void Unwind_10012a2b(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x10) = *(uint *)(unaff_EBP + -0x10) & 0xfffffffe;
    FUN_10009640(*(undefined4 **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012a60(void)

{
  int unaff_EBP;
  
  FUN_100094f0((undefined4 *)(unaff_EBP + -0xf8));
  return;
}



void Unwind_10012a6b(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0xa4) & 1) != 0) {
    *(uint *)(unaff_EBP + -0xa4) = *(uint *)(unaff_EBP + -0xa4) & 0xfffffffe;
    FUN_10009460(*(undefined4 **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012a8a(void)

{
  int unaff_EBP;
  
  FUN_100034b0((undefined4 *)(unaff_EBP + -0xfc));
  return;
}



void Unwind_10012a95(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012a9b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xbc));
  return;
}



void Unwind_10012aa1(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012aa7. Too many branches
                    // WARNING: Treating indirect jump as call
  QFileInfo::~QFileInfo((QFileInfo *)(unaff_EBP + -0xb8));
  return;
}



void Unwind_10012aad(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012ab3. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xf4));
  return;
}



void Unwind_10012ab9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012abc. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_10012ac2(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012ac8. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xd0));
  return;
}



void Unwind_10012ace(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012ad4. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xc0));
  return;
}



void Unwind_10012ada(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012ae0. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x9c));
  return;
}



void Unwind_10012ae6(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012aec. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xe0));
  return;
}



void Unwind_10012af2(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012af8. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -200));
  return;
}



void Unwind_10012afe(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b01. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x6c));
  return;
}



void Unwind_10012b07(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b0d. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xd8));
  return;
}



void Unwind_10012b13(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b19. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xe4));
  return;
}



void Unwind_10012b1f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b22. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10012b28(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b2e. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xe8));
  return;
}



void Unwind_10012b34(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b3a. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x8c));
  return;
}



void Unwind_10012b40(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b46. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xdc));
  return;
}



void Unwind_10012b4c(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b52. Too many branches
                    // WARNING: Treating indirect jump as call
  QDateTime::~QDateTime((QDateTime *)(unaff_EBP + -0xac));
  return;
}



void Unwind_10012b58(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b5b. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x7c));
  return;
}



void Unwind_10012b61(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b67. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xd4));
  return;
}



void Unwind_10012b6d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b70. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x5c));
  return;
}



void Unwind_10012b76(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b7c. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xcc));
  return;
}



void Unwind_10012b82(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b88. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xec));
  return;
}



void Unwind_10012b8e(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b94. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xb0));
  return;
}



void Unwind_10012b9a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012b9d. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x3c));
  return;
}



void Unwind_10012ba3(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012ba9. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0xc4));
  return;
}



void Unwind_10012baf(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012bb2. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10012be0(void)

{
  int unaff_EBP;
  
  FUN_10009520((undefined4 *)(unaff_EBP + -0x80));
  return;
}



void Unwind_10012be8(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -100) & 1) != 0) {
    *(uint *)(unaff_EBP + -100) = *(uint *)(unaff_EBP + -100) & 0xfffffffe;
    FUN_10009460(*(undefined4 **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012c01(void)

{
  int unaff_EBP;
  
  FUN_100034b0((undefined4 *)(unaff_EBP + -0x7c));
  return;
}



void Unwind_10012c09(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012c0c. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x5c));
  return;
}



void Unwind_10012c12(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012c15. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x74));
  return;
}



void Unwind_10012c1b(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012c1e. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_10012c24(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012c27. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x70));
  return;
}



void Unwind_10012c2d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012c30. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x3c));
  return;
}



void Unwind_10012c36(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012c39. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x6c));
  return;
}



void Unwind_10012c3f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012c42. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10012c48(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012c4b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x68));
  return;
}



void Unwind_10012c51(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012c54. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10012c80(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + -0x10));
  return;
}



void Unwind_10012cb0(void)

{
  int unaff_EBP;
  
  operator_delete(*(void **)(unaff_EBP + 0x10));
  return;
}



void Unwind_10012ce0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012ce3. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x10));
  return;
}



void Unwind_10012d10(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012d13. Too many branches
                    // WARNING: Treating indirect jump as call
  QMutexLocker::~QMutexLocker((QMutexLocker *)(unaff_EBP + -0x50));
  return;
}



void Unwind_10012d19(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x54) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x54) = *(uint *)(unaff_EBP + -0x54) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x10012d2c. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString((QString *)(unaff_EBP + -0x44));
    return;
  }
  return;
}



void Unwind_10012d33(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x54) & 2) != 0) {
    *(uint *)(unaff_EBP + -0x54) = *(uint *)(unaff_EBP + -0x54) & 0xfffffffd;
                    // WARNING: Could not recover jumptable at 0x10012d46. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString((QString *)(unaff_EBP + -0x48));
    return;
  }
  return;
}



void Unwind_10012d4d(void)

{
  int unaff_EBP;
  
  FUN_10009640((undefined4 *)(unaff_EBP + -0x58));
  return;
}



void Unwind_10012d55(void)

{
  int unaff_EBP;
  
  FUN_100034b0((undefined4 *)(unaff_EBP + 8));
  return;
}



void Unwind_10012d5d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012d60. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x3c));
  return;
}



void Unwind_10012d66(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012d69. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x54));
  return;
}



void Unwind_10012d6f(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012d72. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x2c));
  return;
}



void Unwind_10012d78(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012d7b. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x4c));
  return;
}



void Unwind_10012d81(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012d84. Too many branches
                    // WARNING: Treating indirect jump as call
  QVariant::~QVariant((QVariant *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10012db0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012db3. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x14));
  return;
}



void Unwind_10012db9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012dbc. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x18));
  return;
}



void Unwind_10012dc2(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x10) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x10) = *(uint *)(unaff_EBP + -0x10) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x10012dd5. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString(*(QString **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012ddc(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012ddf. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + 0xc));
  return;
}



void Unwind_10012e80(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012e83. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10012eb0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012eb3. Too many branches
                    // WARNING: Treating indirect jump as call
  QMutexLocker::~QMutexLocker((QMutexLocker *)(unaff_EBP + -0x18));
  return;
}



void Unwind_10012eb9(void)

{
  int unaff_EBP;
  
  FUN_10009460((undefined4 *)(unaff_EBP + -0x14));
  return;
}



void Unwind_10012ee0(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012ee3. Too many branches
                    // WARNING: Treating indirect jump as call
  QQuickImageProvider::~QQuickImageProvider(*(QQuickImageProvider **)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012ee9(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012eec. Too many branches
                    // WARNING: Treating indirect jump as call
  QDebug::~QDebug((QDebug *)(unaff_EBP + -0x28));
  return;
}



void Unwind_10012f10(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x34) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x34) = *(uint *)(unaff_EBP + -0x34) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x10012f23. Too many branches
                    // WARNING: Treating indirect jump as call
    QImage::~QImage(*(QImage **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_10012f2a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012f2d. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x30));
  return;
}



void Unwind_10012f33(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012f36. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x28));
  return;
}



void Unwind_10012f3c(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012f3f. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + 8));
  return;
}



void Unwind_10012f45(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012f48. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012f4e(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012f51. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + 8));
  return;
}



void Unwind_10012f57(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012f5a. Too many branches
                    // WARNING: Treating indirect jump as call
  QImage::~QImage((QImage *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10012f60(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012f63. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012f69(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x34) & 2) != 0) {
    *(uint *)(unaff_EBP + -0x34) = *(uint *)(unaff_EBP + -0x34) & 0xfffffffd;
                    // WARNING: Could not recover jumptable at 0x10012f7c. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString((QString *)(unaff_EBP + -0x2c));
    return;
  }
  return;
}



void Unwind_10012f83(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x34) & 4) != 0) {
    *(uint *)(unaff_EBP + -0x34) = *(uint *)(unaff_EBP + -0x34) & 0xfffffffb;
                    // WARNING: Could not recover jumptable at 0x10012f96. Too many branches
                    // WARNING: Treating indirect jump as call
    QString::~QString((QString *)(unaff_EBP + -0x28));
    return;
  }
  return;
}



void Unwind_10012f9d(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012fa0. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012fa6(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012fa9. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012faf(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012fb2. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012fb8(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012fbb. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x28));
  return;
}



void Unwind_10012fc1(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012fc4. Too many branches
                    // WARNING: Treating indirect jump as call
  QString::~QString((QString *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012fca(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012fcd. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012fd3(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012fd6. Too many branches
                    // WARNING: Treating indirect jump as call
  QByteArray::~QByteArray((QByteArray *)(unaff_EBP + -0x24));
  return;
}



void Unwind_10012fdc(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x10012fdf. Too many branches
                    // WARNING: Treating indirect jump as call
  QImage::~QImage((QImage *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10013000(void)

{
  int unaff_EBP;
  
  if ((*(uint *)(unaff_EBP + -0x20) & 1) != 0) {
    *(uint *)(unaff_EBP + -0x20) = *(uint *)(unaff_EBP + -0x20) & 0xfffffffe;
                    // WARNING: Could not recover jumptable at 0x10013013. Too many branches
                    // WARNING: Treating indirect jump as call
    QPixmap::~QPixmap(*(QPixmap **)(unaff_EBP + 4));
    return;
  }
  return;
}



void Unwind_1001301a(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001301d. Too many branches
                    // WARNING: Treating indirect jump as call
  QImage::~QImage((QImage *)(unaff_EBP + -0x1c));
  return;
}



void Unwind_10013060(void)

{
  int unaff_EBP;
  
  FUN_10009640((undefined4 *)(unaff_EBP + 8));
  return;
}



void Unwind_10013068(void)

{
  int unaff_EBP;
  
  FUN_10009640((undefined4 *)(unaff_EBP + 8));
  return;
}



void Unwind_10013070(void)

{
  int unaff_EBP;
  
  FUN_10009640((undefined4 *)(unaff_EBP + 8));
  return;
}



void Unwind_10013078(void)

{
  int unaff_EBP;
  
                    // WARNING: Could not recover jumptable at 0x1001307b. Too many branches
                    // WARNING: Treating indirect jump as call
  QJsonArray::~QJsonArray((QJsonArray *)(unaff_EBP + -0x18));
  return;
}



void FUN_100130a0(void)

{
  PTR_vftable_10022000 = (undefined *)std::error_category::vftable;
  return;
}



void FUN_100130b0(void)

{
  PTR_vftable_10022004 = (undefined *)std::error_category::vftable;
  return;
}



void FUN_100130c0(void)

{
  PTR_vftable_10022008 = (undefined *)std::error_category::vftable;
  return;
}



void FUN_100130d0(void)

{
  int iVar1;
  int *this;
  
  if (*DAT_100225f0 != 0) {
    if (*DAT_100225f0 == -1) {
      return;
    }
    LOCK();
    iVar1 = *DAT_100225f0;
    *DAT_100225f0 = iVar1 + -1;
    UNLOCK();
    if (iVar1 + -1 != 0) {
      return;
    }
  }
  this = DAT_100225f0;
  if (DAT_100225f0[3] != 0) {
    param_2_10003760();
    QMapDataBase::freeTree((QMapDataBase *)this,(QMapNodeBase *)this[3],4);
  }
  QMapDataBase::freeData((QMapDataBase *)this);
  return;
}


/*
Unable to decompile 'FUN_10013120'
Cause: 
Low-level Error: Bad size for array of type wchar_t
*/

