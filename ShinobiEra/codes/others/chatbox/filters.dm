proc
	Replace_All(text,replace_list)
		for(var/word in replace_list)
			var/pos = findtext(text,word)
			while(pos)
				text = copytext(text,1,pos) + replace_list[word] + copytext(text,pos+length(word))
				pos = findtext(text,word)
		return text
var
	oocmute=0
	chat_filter = list(//Anti-spam filters
	                   "http:" = "spam:", "byond:" = "spam:", "\n\n" = "\n", "\n" = " ... ", "  " = " ", "\t\t"  = "\t",
	                   "aaa" = "aa", "bbb" = "bb", "ccc" = "cc", "ddd" = "dd", "eee" = "ee", "fff" = "ff", "ggg" = "gg",  //   No word in english ever uses more than
	                   "hhh" = "hh", "iii" = "ii", "jjj" = "jj", "kkk" = "kk", "lll" = "ll", "mmm" = "mm", "nnn" = "nn",  // two of the same letter in a row. Some of
	                   "ooo" = "oo", "ppp" = "pp", "qqq" = "qq", "rrr" = "rr", "sss" = "ss", "ttt" = "tt", "uuu" = "uu",  // these could probably even be set to prevent
	                   "vvv" = "vv", "www" = "ww", "xxx" = "xx", "yyy" = "yy", "zzz" = "zz",                              // two letters, but this is consistent.
	                   "...." = "...",
	                   //Anti-bypass filers (anti-idiot messes these up)
	                   "p u s s y" = "pussy", "f u c k" = "fuck", "f u ck" = "fuck",
	                   //Anti-idiot filters
	                   " u " = " you ", " ur " = " your ",
	                   //Anti-bypass filters (General)
	                   "b!itch" = "bitch", "fuk" = "fuck", "sh!t" = "shit", "fux" = "fuck", "bitach" = "bitch",
	                   "biatch" = "bitch", "pussie" = "pussy", "f@ggot" = "faggot", "g@y" = "gay", "b1tch" = "bitch",
	                   "fuuck" = "fuck", "fvck" = "fuck", "bi tch" = "bitch", "fa g" = "fag", "p ussy" = "pussy",
	                   "b itch" = "bitch", "ga.y" = "gay", "g.ay" = "gay", "g.a.y" = "gay", "ga y" = "gay", "g ay" = "gay",
	                   "g a y" = "gay", "fsck" = "fuck", "shyt" = "shit", "nigga" = "nigger", "btch" = "bitch", "fck" = "fuck",
	                   "gaay" = "gay", "f.uck" = "fuck", "fu.ck" = "fuck", "fuc.k" = "fuck", "f.u.ck" = "fuck", "f.uc.k" = "fuck",
	                   "f.u.c.k" = "fuck", "fk " = "fuck ", " fk" = " fuck", "fkin" = "fucking", "fu ck" = "fuck", "f uck" = "fuck",
	                   "fuc k" = "fuck", "fu c k" = "fuck", "f uc k" = "fuck", "bicth" = "bitch", "bish" = "bitch", "puussyy" = "pussy",
	                   "b.itch" = "bitch", "n1gga" = "nigger", "pu$$y" = "pussy", "shiit" = "shit", "faagg" = "fag", "f4g" = "fag",
	                   "fa.g" = "fag",
	                   // Word fixes
	                   "afuck" = "afk",
	                   //Inappropriate word filters
	                   "fuck" = "****", "bastard" = "****", "nigger" = "****", "cunt" = "****", "pussy" = "cat",
	                   "bitch" = "dog", "shit" = "poop", "gay" = "happy", "faggot" = "****", "fag" = "****",
	                   //Anti-bypass filters (Words that are a substring of their non-bypass form) (aka. words that will crash it/make it not work right if put earlier)
	                   "puss" = "cat", "fuc" = "****", "nig " = "**** ", "nigs" = "****", "nigz" = "****")
	whitespace_only_chat_filter = list("\n\n" = "\n", "\n" = " ... ", "  " = " ", "\t\t"  = "\t", "...." = "...")
mob
	verb
//		say(var/t as text)
		WorldSay(t as text|null)
//			set/hidden=1
			t = Replace_All(t,chat_filter)
			newocc(world, "[usr.key]: [html_encode(t)]", rgb(100,250,100))