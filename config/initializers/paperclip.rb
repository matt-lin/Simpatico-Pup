require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
  
  Paperclip.interpolates :hashed_path do |attachment, style|
  secret = 'YP#nb-kjGJpCF4_=ce2QYPt#!-VL33pKz8$aGN7CEuun-e8XeDb$3yVKDFXrSA7$+#wpDQfj^wR4tf^3FWbL4?G#taE^?!eE9Fswch_wNxE$G
  VaM5QWcH49RpHutsv8-U%bcGGU9=-CfTqUe7=JHvqf@Qz$fPXFJ_wnDaecVMBdWC7J3hFnV4m7Sa3tWcntxhYaszYScc@YdAujx7gvu3@DsZXQJ*ZzyZHnM
  T%n5%KxwZnQt=mrFP+H*RZPbWDmk'
  hash = Digest::MD5.hexdigest("--#{attachment.class.name}--#{attachment.instance.id}--#{secret}--")
  hash_path = ''
  6.times { hash_path += '/' + hash.slice!(0..2) }
  hash_path[1..24]
end
  
  
end