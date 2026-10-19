# 07 — Repoyu ve ekranımı öğret

**Ne zaman:** Bilmediğim bir teknolojide (ör. React + TS) AI'a bir iş yaptırdım. Hem repoyu hem de yazılan kodu baştan sona anlamak istiyorum. Birkaç saatlik bir oturum.

**İpucu:** Teach skill'ini çağırıp bu prompt'u ver. Aşama 0'ın çıktısını (kavram envanteri) dikkatli oku; bütün oturumu o belirler. Oturum uzarsa aşamalar arasında "şimdiye kadar öğrendiklerimin özetini çıkar" de, gerekirse yeni oturumu bu özetle aç.

```
Bugün bana bu repo üzerinden [TEKNOLOJİ, ör. React + TypeScript (TSX)]
temeli öğretmeni istiyorum. ~[SÜRE] saatim var, acelem yok. Detaylı anlat
ama boş detaya boğma: hedef, bu repoyu ve kendi ekranımı gerçekten anlamak
için gereken temeller.

ARKA PLANIM
Java / Spring Boot backend geliştiricisiyim. [TEKNOLOJİ] daha önce hiç
yazmadım, JS/TS bilgim zayıf, frontend araçlarını (npm, Vite vb.) bilmiyorum.
Bu repoda bir ekran yaptım (AI yazdı), kodu anlamak istiyorum.
Ekranımın dosyaları: [DOSYA YOLLARI]

GENEL KURALLAR
- Hiçbir dosyayı değiştirme, kod yazma. Sadece oku ve açıkla.
- Tek seferde tek konu anlat, sonra dur ve "devam" dememi bekle.
- Her şeyi bu repodaki gerçek dosyalardan örnekle anlat (dosya + satır).
- Anlattığın her şeyi [GENEL] (genel React/TS/frontend bilgisi) veya
  [BU REPOYA ÖZEL] (bu kurumun/ekibin kuralı, kalıbı) diye etiketle.
- Uygun yerde Java/Spring/Maven karşılığıyla benzetme yap (ör. package.json ↔
  pom.xml), benzetmenin nerede çöktüğünü de söyle.
- Her mantıksal parçanın sonunda 1-2 soru sor, cevabımı değerlendir,
  yanlışsam düzelt.

AŞAMA 0 — REPOYU TARA (bana henüz ders anlatma)
Repoyu genel olarak tara: README ve iç dokümanlar, package.json,
package-lock.json, build/config dosyaları (Vite, tsconfig, lint/format
config, .env dosyaları vb.), Jenkinsfile ve CI/CD dosyaları, klasör yapısı,
routing, state/data yönetimi, API katmanı, ortak component kütüphanesi ve
birkaç mevcut sayfa. Benim dosyalarımı da oku.
Sonra bana şunları ver:
1. Repoyu 10-15 cümlede özetleyen kısa bir genel bakış.
2. KAVRAM ENVANTERİ: Bu repoyu ve ekranımı anlamak için bilmem gereken
   kavramların listesi. Her kavram için: ne olduğu (tek cümle), repoda nerede
   geçtiği, [GENEL]/[BU REPOYA ÖZEL] etiketi ve bilmem gereken seviye
   ("ne işe yaradığını bilmen yeter" / "iyi anlaman lazım").
   Gruplar:
   a) Araçlar ve altyapı: package.json, package-lock.json, node_modules,
      npm script'leri, Vite, tsconfig, lint, .env, Jenkinsfile/CI, build
      çıktısı vb. (repoda ne varsa)
   b) JS/TS/TSX sözdizimi: özellikle benim dosyalarımda geçenler
   c) React temelleri: component, props, state, hook'lar, render, vb.
   d) Bu repoya özel yapı: klasör düzeni, routing, API katmanı, state
      yönetimi, ortak component'ler, isimlendirme ve yazım kuralları
3. Bu envantere göre sıralı bir DERS PLANI (her ders ~15-30 dk).
Burada dur ve onayımı bekle. Listeye ekleme/çıkarma yapabilirim.

AŞAMA 1 — DERSLER (Teach skill ile)
Onayladığım plana göre dersleri sırayla işle. Araçlar ve altyapı → JS/TS
sözdizimi → React temelleri → repoya özel yapı sırasıyla git. Her ders bu
repodaki gerçek örneklere dayansın.

AŞAMA 2 — DİĞER SAYFALAR NASIL KURGULANMIŞ
Repodaki 1-2 temsili mevcut sayfayı seç (neden onları seçtiğini söyle).
Bir sayfanın bu repoda tipik olarak nasıl kurulduğunu göster: hangi dosyalar,
hangi sırayla, hangi ortak component ve hook'larla, veri nereden geliyor.

AŞAMA 3 — BENİM SAYFAM, ADIM ADIM
Dosyalarımı bağımlılık sırasıyla (tipler → servis/API → hook → component
→ sayfa) blok blok anlat. Her blokta: ne yapıyor, neden böyle yazılmış, hangi
dersteki kavrama denk geliyor. Sonra ekrandaki bir kullanıcı aksiyonunu
uçtan uca iz sür (tıklama → state → API çağrısı → yeniden render).

AŞAMA 4 — KURALLARA UYUM
Ekranımı repo kurallarına ve Aşama 2'deki sayfalara göre değerlendir:
kurala uymayan yerler, kullanılmamış ortak component'ler, farklı yapılmış
kalıplar, gereksiz/şüpheli kod. Her madde için nedenini açıkla. Sadece liste
ver, düzeltme yapma.

AŞAMA 5 — TEACH-BACK
Ekranımın nasıl çalıştığını ben anlatacağım. Sen eksiklerimi ve yanlışlarımı
söyle, gerekirse ilgili konuyu kısaca tekrar et.

Aşama 0 ile başla.
```

**Notlar:**
- Her dersin sonunda 3-5 satırı kendi cümlelerimle yazarım, AI'a kontrol ettiririm. Notları iş reposuna commit'lemem.
- Aşama 4'te referans olarak mümkünse ekipte iyi bilinen, kıdemli birinin yazdığı bir ekranı seçerim.
- Aşama 4'ün çıkardığı liste, sonra review feedback'leriyle birlikte düzelteceğim işin girdisidir.
