$(document).ready ->
  hms = document.location.toString().split("#")
  if (hms.length > 1)
    pafm = hms[1].split("afm")
    if (pafm.length > 1)
      afid = pafm[1]
      console.debug "registered affiliate code #{afid}!"
      $.post "affiliate_landings", { affiliate_id: afid }

