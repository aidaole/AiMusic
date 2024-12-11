import '../../music/models/recommend_songs/song.dart';

class ArtistPlayList {
  ArtistPlayList({
    List<Song>? songs,
    bool? more,
    int? total,
    int? code,
  }) {
    _songs = songs;
    _more = more;
    _total = total;
    _code = code;
  }

  ArtistPlayList.fromJson(dynamic json) {
    if (json['songs'] != null) {
      _songs = [];
      json['songs'].forEach((v) {
        _songs?.add(Song.fromJson(v));
      });
    }
    _more = json['more'];
    _total = json['total'];
    _code = json['code'];
  }
  List<Song>? _songs;
  bool? _more;
  int? _total;
  int? _code;
  ArtistPlayList copyWith({
    List<Song>? songs,
    bool? more,
    int? total,
    int? code,
  }) =>
      ArtistPlayList(
        songs: songs ?? _songs,
        more: more ?? _more,
        total: total ?? _total,
        code: code ?? _code,
      );
  List<Song>? get songs => _songs;
  bool? get more => _more;
  int? get total => _total;
  int? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_songs != null) {
      map['songs'] = _songs?.map((v) => v.toJson()).toList();
    }
    map['more'] = _more;
    map['total'] = _total;
    map['code'] = _code;
    return map;
  }
}

class Privilege {
  Privilege({
    int? id,
    int? fee,
    int? payed,
    int? st,
    int? pl,
    int? dl,
    int? sp,
    int? cp,
    int? subp,
    bool? cs,
    int? maxbr,
    int? fl,
    bool? toast,
    int? flag,
    bool? preSell,
    int? playMaxbr,
    int? downloadMaxbr,
    String? maxBrLevel,
    String? playMaxBrLevel,
    String? downloadMaxBrLevel,
    String? plLevel,
    String? dlLevel,
    String? flLevel,
    dynamic rscl,
    FreeTrialPrivilege? freeTrialPrivilege,
    int? rightSource,
    List<ChargeInfoList>? chargeInfoList,
    int? code,
    dynamic message,
  }) {
    _id = id;
    _fee = fee;
    _payed = payed;
    _st = st;
    _pl = pl;
    _dl = dl;
    _sp = sp;
    _cp = cp;
    _subp = subp;
    _cs = cs;
    _maxbr = maxbr;
    _fl = fl;
    _toast = toast;
    _flag = flag;
    _preSell = preSell;
    _playMaxbr = playMaxbr;
    _downloadMaxbr = downloadMaxbr;
    _maxBrLevel = maxBrLevel;
    _playMaxBrLevel = playMaxBrLevel;
    _downloadMaxBrLevel = downloadMaxBrLevel;
    _plLevel = plLevel;
    _dlLevel = dlLevel;
    _flLevel = flLevel;
    _rscl = rscl;
    _freeTrialPrivilege = freeTrialPrivilege;
    _rightSource = rightSource;
    _chargeInfoList = chargeInfoList;
    _code = code;
    _message = message;
  }

  Privilege.fromJson(dynamic json) {
    _id = json['id'];
    _fee = json['fee'];
    _payed = json['payed'];
    _st = json['st'];
    _pl = json['pl'];
    _dl = json['dl'];
    _sp = json['sp'];
    _cp = json['cp'];
    _subp = json['subp'];
    _cs = json['cs'];
    _maxbr = json['maxbr'];
    _fl = json['fl'];
    _toast = json['toast'];
    _flag = json['flag'];
    _preSell = json['preSell'];
    _playMaxbr = json['playMaxbr'];
    _downloadMaxbr = json['downloadMaxbr'];
    _maxBrLevel = json['maxBrLevel'];
    _playMaxBrLevel = json['playMaxBrLevel'];
    _downloadMaxBrLevel = json['downloadMaxBrLevel'];
    _plLevel = json['plLevel'];
    _dlLevel = json['dlLevel'];
    _flLevel = json['flLevel'];
    _rscl = json['rscl'];
    _freeTrialPrivilege = json['freeTrialPrivilege'] != null
        ? FreeTrialPrivilege.fromJson(json['freeTrialPrivilege'])
        : null;
    _rightSource = json['rightSource'];
    if (json['chargeInfoList'] != null) {
      _chargeInfoList = [];
      json['chargeInfoList'].forEach((v) {
        _chargeInfoList?.add(ChargeInfoList.fromJson(v));
      });
    }
    _code = json['code'];
    _message = json['message'];
  }
  int? _id;
  int? _fee;
  int? _payed;
  int? _st;
  int? _pl;
  int? _dl;
  int? _sp;
  int? _cp;
  int? _subp;
  bool? _cs;
  int? _maxbr;
  int? _fl;
  bool? _toast;
  int? _flag;
  bool? _preSell;
  int? _playMaxbr;
  int? _downloadMaxbr;
  String? _maxBrLevel;
  String? _playMaxBrLevel;
  String? _downloadMaxBrLevel;
  String? _plLevel;
  String? _dlLevel;
  String? _flLevel;
  dynamic _rscl;
  FreeTrialPrivilege? _freeTrialPrivilege;
  int? _rightSource;
  List<ChargeInfoList>? _chargeInfoList;
  int? _code;
  dynamic _message;
  Privilege copyWith({
    int? id,
    int? fee,
    int? payed,
    int? st,
    int? pl,
    int? dl,
    int? sp,
    int? cp,
    int? subp,
    bool? cs,
    int? maxbr,
    int? fl,
    bool? toast,
    int? flag,
    bool? preSell,
    int? playMaxbr,
    int? downloadMaxbr,
    String? maxBrLevel,
    String? playMaxBrLevel,
    String? downloadMaxBrLevel,
    String? plLevel,
    String? dlLevel,
    String? flLevel,
    dynamic rscl,
    FreeTrialPrivilege? freeTrialPrivilege,
    int? rightSource,
    List<ChargeInfoList>? chargeInfoList,
    int? code,
    dynamic message,
  }) =>
      Privilege(
        id: id ?? _id,
        fee: fee ?? _fee,
        payed: payed ?? _payed,
        st: st ?? _st,
        pl: pl ?? _pl,
        dl: dl ?? _dl,
        sp: sp ?? _sp,
        cp: cp ?? _cp,
        subp: subp ?? _subp,
        cs: cs ?? _cs,
        maxbr: maxbr ?? _maxbr,
        fl: fl ?? _fl,
        toast: toast ?? _toast,
        flag: flag ?? _flag,
        preSell: preSell ?? _preSell,
        playMaxbr: playMaxbr ?? _playMaxbr,
        downloadMaxbr: downloadMaxbr ?? _downloadMaxbr,
        maxBrLevel: maxBrLevel ?? _maxBrLevel,
        playMaxBrLevel: playMaxBrLevel ?? _playMaxBrLevel,
        downloadMaxBrLevel: downloadMaxBrLevel ?? _downloadMaxBrLevel,
        plLevel: plLevel ?? _plLevel,
        dlLevel: dlLevel ?? _dlLevel,
        flLevel: flLevel ?? _flLevel,
        rscl: rscl ?? _rscl,
        freeTrialPrivilege: freeTrialPrivilege ?? _freeTrialPrivilege,
        rightSource: rightSource ?? _rightSource,
        chargeInfoList: chargeInfoList ?? _chargeInfoList,
        code: code ?? _code,
        message: message ?? _message,
      );
  int? get id => _id;
  int? get fee => _fee;
  int? get payed => _payed;
  int? get st => _st;
  int? get pl => _pl;
  int? get dl => _dl;
  int? get sp => _sp;
  int? get cp => _cp;
  int? get subp => _subp;
  bool? get cs => _cs;
  int? get maxbr => _maxbr;
  int? get fl => _fl;
  bool? get toast => _toast;
  int? get flag => _flag;
  bool? get preSell => _preSell;
  int? get playMaxbr => _playMaxbr;
  int? get downloadMaxbr => _downloadMaxbr;
  String? get maxBrLevel => _maxBrLevel;
  String? get playMaxBrLevel => _playMaxBrLevel;
  String? get downloadMaxBrLevel => _downloadMaxBrLevel;
  String? get plLevel => _plLevel;
  String? get dlLevel => _dlLevel;
  String? get flLevel => _flLevel;
  dynamic get rscl => _rscl;
  FreeTrialPrivilege? get freeTrialPrivilege => _freeTrialPrivilege;
  int? get rightSource => _rightSource;
  List<ChargeInfoList>? get chargeInfoList => _chargeInfoList;
  int? get code => _code;
  dynamic get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fee'] = _fee;
    map['payed'] = _payed;
    map['st'] = _st;
    map['pl'] = _pl;
    map['dl'] = _dl;
    map['sp'] = _sp;
    map['cp'] = _cp;
    map['subp'] = _subp;
    map['cs'] = _cs;
    map['maxbr'] = _maxbr;
    map['fl'] = _fl;
    map['toast'] = _toast;
    map['flag'] = _flag;
    map['preSell'] = _preSell;
    map['playMaxbr'] = _playMaxbr;
    map['downloadMaxbr'] = _downloadMaxbr;
    map['maxBrLevel'] = _maxBrLevel;
    map['playMaxBrLevel'] = _playMaxBrLevel;
    map['downloadMaxBrLevel'] = _downloadMaxBrLevel;
    map['plLevel'] = _plLevel;
    map['dlLevel'] = _dlLevel;
    map['flLevel'] = _flLevel;
    map['rscl'] = _rscl;
    if (_freeTrialPrivilege != null) {
      map['freeTrialPrivilege'] = _freeTrialPrivilege?.toJson();
    }
    map['rightSource'] = _rightSource;
    if (_chargeInfoList != null) {
      map['chargeInfoList'] = _chargeInfoList?.map((v) => v.toJson()).toList();
    }
    map['code'] = _code;
    map['message'] = _message;
    return map;
  }
}

class ChargeInfoList {
  ChargeInfoList({
    int? rate,
    dynamic chargeUrl,
    dynamic chargeMessage,
    int? chargeType,
  }) {
    _rate = rate;
    _chargeUrl = chargeUrl;
    _chargeMessage = chargeMessage;
    _chargeType = chargeType;
  }

  ChargeInfoList.fromJson(dynamic json) {
    _rate = json['rate'];
    _chargeUrl = json['chargeUrl'];
    _chargeMessage = json['chargeMessage'];
    _chargeType = json['chargeType'];
  }
  int? _rate;
  dynamic _chargeUrl;
  dynamic _chargeMessage;
  int? _chargeType;
  ChargeInfoList copyWith({
    int? rate,
    dynamic chargeUrl,
    dynamic chargeMessage,
    int? chargeType,
  }) =>
      ChargeInfoList(
        rate: rate ?? _rate,
        chargeUrl: chargeUrl ?? _chargeUrl,
        chargeMessage: chargeMessage ?? _chargeMessage,
        chargeType: chargeType ?? _chargeType,
      );
  int? get rate => _rate;
  dynamic get chargeUrl => _chargeUrl;
  dynamic get chargeMessage => _chargeMessage;
  int? get chargeType => _chargeType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = _rate;
    map['chargeUrl'] = _chargeUrl;
    map['chargeMessage'] = _chargeMessage;
    map['chargeType'] = _chargeType;
    return map;
  }
}

class FreeTrialPrivilege {
  FreeTrialPrivilege({
    bool? resConsumable,
    bool? userConsumable,
    int? listenType,
    int? cannotListenReason,
    dynamic playReason,
    dynamic freeLimitTagType,
  }) {
    _resConsumable = resConsumable;
    _userConsumable = userConsumable;
    _listenType = listenType;
    _cannotListenReason = cannotListenReason;
    _playReason = playReason;
    _freeLimitTagType = freeLimitTagType;
  }

  FreeTrialPrivilege.fromJson(dynamic json) {
    _resConsumable = json['resConsumable'];
    _userConsumable = json['userConsumable'];
    _listenType = json['listenType'];
    _cannotListenReason = json['cannotListenReason'];
    _playReason = json['playReason'];
    _freeLimitTagType = json['freeLimitTagType'];
  }
  bool? _resConsumable;
  bool? _userConsumable;
  int? _listenType;
  int? _cannotListenReason;
  dynamic _playReason;
  dynamic _freeLimitTagType;
  FreeTrialPrivilege copyWith({
    bool? resConsumable,
    bool? userConsumable,
    int? listenType,
    int? cannotListenReason,
    dynamic playReason,
    dynamic freeLimitTagType,
  }) =>
      FreeTrialPrivilege(
        resConsumable: resConsumable ?? _resConsumable,
        userConsumable: userConsumable ?? _userConsumable,
        listenType: listenType ?? _listenType,
        cannotListenReason: cannotListenReason ?? _cannotListenReason,
        playReason: playReason ?? _playReason,
        freeLimitTagType: freeLimitTagType ?? _freeLimitTagType,
      );
  bool? get resConsumable => _resConsumable;
  bool? get userConsumable => _userConsumable;
  int? get listenType => _listenType;
  int? get cannotListenReason => _cannotListenReason;
  dynamic get playReason => _playReason;
  dynamic get freeLimitTagType => _freeLimitTagType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resConsumable'] = _resConsumable;
    map['userConsumable'] = _userConsumable;
    map['listenType'] = _listenType;
    map['cannotListenReason'] = _cannotListenReason;
    map['playReason'] = _playReason;
    map['freeLimitTagType'] = _freeLimitTagType;
    return map;
  }
}

class M {
  M({
    int? br,
    int? fid,
    int? size,
    int? vd,
    int? sr,
  }) {
    _br = br;
    _fid = fid;
    _size = size;
    _vd = vd;
    _sr = sr;
  }

  M.fromJson(dynamic json) {
    _br = json['br'];
    _fid = json['fid'];
    _size = json['size'];
    _vd = json['vd'];
    _sr = json['sr'];
  }
  int? _br;
  int? _fid;
  int? _size;
  int? _vd;
  int? _sr;
  M copyWith({
    int? br,
    int? fid,
    int? size,
    int? vd,
    int? sr,
  }) =>
      M(
        br: br ?? _br,
        fid: fid ?? _fid,
        size: size ?? _size,
        vd: vd ?? _vd,
        sr: sr ?? _sr,
      );
  int? get br => _br;
  int? get fid => _fid;
  int? get size => _size;
  int? get vd => _vd;
  int? get sr => _sr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['br'] = _br;
    map['fid'] = _fid;
    map['size'] = _size;
    map['vd'] = _vd;
    map['sr'] = _sr;
    return map;
  }
}

class L {
  L({
    int? br,
    int? fid,
    int? size,
    int? vd,
    int? sr,
  }) {
    _br = br;
    _fid = fid;
    _size = size;
    _vd = vd;
    _sr = sr;
  }

  L.fromJson(dynamic json) {
    _br = json['br'];
    _fid = json['fid'];
    _size = json['size'];
    _vd = json['vd'];
    _sr = json['sr'];
  }
  int? _br;
  int? _fid;
  int? _size;
  int? _vd;
  int? _sr;
  L copyWith({
    int? br,
    int? fid,
    int? size,
    int? vd,
    int? sr,
  }) =>
      L(
        br: br ?? _br,
        fid: fid ?? _fid,
        size: size ?? _size,
        vd: vd ?? _vd,
        sr: sr ?? _sr,
      );
  int? get br => _br;
  int? get fid => _fid;
  int? get size => _size;
  int? get vd => _vd;
  int? get sr => _sr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['br'] = _br;
    map['fid'] = _fid;
    map['size'] = _size;
    map['vd'] = _vd;
    map['sr'] = _sr;
    return map;
  }
}

class Sq {
  Sq({
    int? br,
    int? fid,
    int? size,
    int? vd,
    int? sr,
  }) {
    _br = br;
    _fid = fid;
    _size = size;
    _vd = vd;
    _sr = sr;
  }

  Sq.fromJson(dynamic json) {
    _br = json['br'];
    _fid = json['fid'];
    _size = json['size'];
    _vd = json['vd'];
    _sr = json['sr'];
  }
  int? _br;
  int? _fid;
  int? _size;
  int? _vd;
  int? _sr;
  Sq copyWith({
    int? br,
    int? fid,
    int? size,
    int? vd,
    int? sr,
  }) =>
      Sq(
        br: br ?? _br,
        fid: fid ?? _fid,
        size: size ?? _size,
        vd: vd ?? _vd,
        sr: sr ?? _sr,
      );
  int? get br => _br;
  int? get fid => _fid;
  int? get size => _size;
  int? get vd => _vd;
  int? get sr => _sr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['br'] = _br;
    map['fid'] = _fid;
    map['size'] = _size;
    map['vd'] = _vd;
    map['sr'] = _sr;
    return map;
  }
}

class H {
  H({
    int? br,
    int? fid,
    int? size,
    int? vd,
    int? sr,
  }) {
    _br = br;
    _fid = fid;
    _size = size;
    _vd = vd;
    _sr = sr;
  }

  H.fromJson(dynamic json) {
    _br = json['br'];
    _fid = json['fid'];
    _size = json['size'];
    _vd = json['vd'];
    _sr = json['sr'];
  }
  int? _br;
  int? _fid;
  int? _size;
  int? _vd;
  int? _sr;
  H copyWith({
    int? br,
    int? fid,
    int? size,
    int? vd,
    int? sr,
  }) =>
      H(
        br: br ?? _br,
        fid: fid ?? _fid,
        size: size ?? _size,
        vd: vd ?? _vd,
        sr: sr ?? _sr,
      );
  int? get br => _br;
  int? get fid => _fid;
  int? get size => _size;
  int? get vd => _vd;
  int? get sr => _sr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['br'] = _br;
    map['fid'] = _fid;
    map['size'] = _size;
    map['vd'] = _vd;
    map['sr'] = _sr;
    return map;
  }
}

class Al {
  Al({
    int? id,
    String? name,
    String? picStr,
    int? pic,
  }) {
    _id = id;
    _name = name;
    _picStr = picStr;
    _pic = pic;
  }

  Al.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _picStr = json['pic_str'];
    _pic = json['pic'];
  }
  int? _id;
  String? _name;
  String? _picStr;
  int? _pic;
  Al copyWith({
    int? id,
    String? name,
    String? picStr,
    int? pic,
  }) =>
      Al(
        id: id ?? _id,
        name: name ?? _name,
        picStr: picStr ?? _picStr,
        pic: pic ?? _pic,
      );
  int? get id => _id;
  String? get name => _name;
  String? get picStr => _picStr;
  int? get pic => _pic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['pic_str'] = _picStr;
    map['pic'] = _pic;
    return map;
  }
}

class Ar {
  Ar({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Ar.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  Ar copyWith({
    int? id,
    String? name,
  }) =>
      Ar(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
