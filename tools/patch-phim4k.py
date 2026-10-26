# [Update: 26/10/2026 21:10]
# Script Python tu dong patch smali cho Phim 4K Android TV
# Bo qua hop thoai server dialog (phat 1 cham) va chan update popup

import os
import re
import sys

def patch_ota_service(src_dir):
    path = os.path.join(src_dir, "smali", "com", "files", "codes", "service", "OTAUpdateService.smali")
    if not os.path.exists(path):
        print(f"[!] Khong tim thay {path}")
        return False
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    # Pattern for isUpdateAvailable
    pattern = r"(\.method public isUpdateAvailable\(Lcom/files/codes/service/OTAUpdateService\$b;\)Z[\s\S]*?\.locals \d+)([\s\S]*?)(\.end method)"
    replacement = r"\1\n\n    const/4 v0, 0x0\n\n    return v0\n\3"
    
    new_content, count = re.subn(pattern, replacement, content)
    if count > 0:
        with open(path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print("[+] Da patch OTAUpdateService (isUpdateAvailable -> false)")
        return True
    else:
        print("[!] Khong tim thay method isUpdateAvailable de patch")
        return False

def patch_apktool_yml(src_dir):
    path = os.path.join(src_dir, "apktool.yml")
    if not os.path.exists(path):
        print(f"[!] Khong tim thay {path}")
        return False
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    content = re.sub(r"versionCode:\s*'?\d+'?", "versionCode: '999999'", content)
    content = re.sub(r"versionName:\s*([^\n]+)", r"versionName: \1-mod", content)

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("[+] Da patch apktool.yml (versionCode: 999999)")
    return True

def patch_hero_style_fragment(src_dir):
    path = os.path.join(src_dir, "smali", "com", "files", "codes", "view", "fragments", "HeroStyleMovieDetailsFragment.smali")
    if not os.path.exists(path):
        print(f"[!] Khong tim thay {path}")
        return False
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    pattern = r"(:cond_1\s+)(invoke-virtual \{p0\}, Landroidx/fragment/app/Fragment;->getActivity[\s\S]*?goto :goto_1)"
    replacement = (
        r"\1invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z\n\n"
        r"    move-result p1\n\n"
        r"    if-nez p1, :cond_3\n\n"
        r"    new-instance p1, Lcom/files/codes/view/fragments/HeroStyleMovieDetailsFragment$m;\n\n"
        r"    invoke-direct {p1, p0}, Lcom/files/codes/view/fragments/HeroStyleMovieDetailsFragment$m;-><init>(Lcom/files/codes/view/fragments/HeroStyleMovieDetailsFragment;)V\n\n"
        r"    const/4 v1, 0x0\n\n"
        r"    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;\n\n"
        r"    move-result-object v0\n\n"
        r"    check-cast v0, Lcom/files/codes/model/Video;\n\n"
        r"    const/4 v2, 0x0\n\n"
        r"    invoke-virtual {p1, v2, v0, v1, v2}, Lcom/files/codes/view/fragments/HeroStyleMovieDetailsFragment$m;->a(Landroid/view/View;Lcom/files/codes/model/Video;ILs1/c$b;)V\n\n"
        r"    return-void"
    )

    new_content, count = re.subn(pattern, replacement, content)
    if count > 0:
        with open(path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print("[+] Da patch HeroStyleMovieDetailsFragment (auto play 1 cham)")
        return True
    else:
        print("[*] HeroStyleMovieDetailsFragment co the da duoc patch hoac khong khop pattern")
        return True

def patch_video_details_fragment(src_dir):
    path = os.path.join(src_dir, "smali", "com", "files", "codes", "view", "fragments", "VideoDetailsFragment.smali")
    if not os.path.exists(path):
        print(f"[!] Khong tim thay {path}")
        return False
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    pattern = r"(:cond_1\s+)(invoke-virtual \{p0\}, Landroidx/fragment/app/Fragment;->getActivity[\s\S]*?goto :goto_1)"
    replacement = (
        r"\1invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z\n\n"
        r"    move-result p1\n\n"
        r"    if-nez p1, :cond_3\n\n"
        r"    new-instance p1, Landroid/app/Dialog;\n\n"
        r"    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/l;\n\n"
        r"    move-result-object v1\n\n"
        r"    invoke-direct {p1, v1}, Landroid/app/Dialog;-><init>(Landroid/content/Context;)V\n\n"
        r"    new-instance v1, Lcom/files/codes/view/fragments/VideoDetailsFragment$g;\n\n"
        r"    invoke-direct {v1, p0, v0, p1}, Lcom/files/codes/view/fragments/VideoDetailsFragment$g;-><init>(Lcom/files/codes/view/fragments/VideoDetailsFragment;Ljava/util/List;Landroid/app/Dialog;)V\n\n"
        r"    const/4 p1, 0x0\n\n"
        r"    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;\n\n"
        r"    move-result-object v0\n\n"
        r"    check-cast v0, Lcom/files/codes/model/Video;\n\n"
        r"    const/4 v2, 0x0\n\n"
        r"    invoke-virtual {v1, v2, v0, p1, v2}, Lcom/files/codes/view/fragments/VideoDetailsFragment$g;->a(Landroid/view/View;Lcom/files/codes/model/Video;ILs1/c$b;)V\n\n"
        r"    return-void"
    )

    new_content, count = re.subn(pattern, replacement, content)
    if count > 0:
        with open(path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print("[+] Da patch VideoDetailsFragment (auto play 1 cham)")
        return True
    else:
        print("[*] VideoDetailsFragment co the da duoc patch hoac khong khop pattern")
        return True

def main():
    if len(sys.argv) < 2:
        print(f"Su dung: {sys.argv[0]} <duong_dan_thu_muc_decompile>")
        sys.exit(1)
    src_dir = sys.argv[1]
    patch_ota_service(src_dir)
    patch_apktool_yml(src_dir)
    patch_hero_style_fragment(src_dir)
    patch_video_details_fragment(src_dir)
    print("[✓] Hoan tat toan bo patch smali.")

if __name__ == "__main__":
    main()
