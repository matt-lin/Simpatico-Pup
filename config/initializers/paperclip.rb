#Iter 2-2 Improved security for upload attachment (By Gung Hiu Ho, Licong Wang)
require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
  
  Paperclip.interpolates :hashed_path do |attachment, style|
    secret = 'eG#?eQpw*3MKRt4VeVJLDWJc=HJD5PfLXW5ukHGE_SZQQSygjG6ya!8jFUhws_
    k#xp4yJ%tyMBhaNma%RUk&a9!urrSXNfM!X_fLCT5E*MEgn+eDKPpHwMsKBV=$d4Jy9t&h5_
    EZ@6ZNscFRTKF8cya9Rzhdg9mJLdnn?Gu@cKXGXmT6=Dt$PM$#?NfcmcUK*seC@h_=PLdd_
    qztx6+kZcMA?Cb87@T@cmdGaDU2?BV=TG!kKznH&56-G3Q&&!CtmuepbRUKHeQa5nRYqKzA
    qxcEacTU#2tBa9B!$+kx8!%kATngkPz+Z?fQ4Zen=JvK&amykQbM#9hSzmYwP$6vTTFS5^z
    yANG+pB*At-b%X_qQ#CKvb^-+T7ZuA6Pf-b&6YMtfCjW?uB+GWP@yC?b3fA^mqvBg5Dr&tK
    @_*Bh#_$AL$JSZGjxV-afjGneNDjvQ+kZuBKn7PCeMrhM$-BV3!ywFr=7WnvsnddVv#ZqS^
    U^^yL^Q9!BvdPtdxNYDSQr5spQc$hexC5Tv*894fU#LNNxzpwB#tqda7U^gRNdt%xfe%Ykq
    ?E-%kbXTYR@yaB+9$=!gZT6gwC5CmPS2Zw!%QE$$AUvSs^Dt4$k6Q9kx_8Vgw3JYp?GC6K%
    HNPJJ4FXsQ&Q8tZx^&Mx?_kXSGZGSCqTwLBr6k_CjBEAQpuk!aX+x#cAuZ8q-S#q@&tJ$zK
    4gzzd4D64@G7kFE6mcbeqSDqg8s8Uzu4bsQxzFV9rvJq=P2uVaP3-gXz-ryfNM@g4X=n!&r
    r+8*VVd-^7ba3nbN6fZF*9?J!HY3jVea2CuEVdaamZHc-^B6r89*%?rPaX8srW+-P5j-*A
    qqL%8zL=+Z+f=3C5zn!EbPw$N4#-mmL$+=j7sqx8j&bg+e=5UDJksnG8zB5kbS7b$bQ7C+k
    XH-Sw-j+3RgCsKX^YBhx9qF@MjsWdREN!?K#qfT-Ecp8mb4z4^DT%WzJYTbLdWHW+S#+b5x
    upc6d-FS$W9+p^__4g@X3xp8y4fJwJKqj@&dc@7'
    hash = Digest::MD5.hexdigest("--#{attachment.class.name}--#{attachment.instance.id}--#{secret}--")
    hash_path = ''
    1.times { hash_path += '/' + hash.slice!(0..32) }
    hash_path[1..32]
  end
end