# Engineering Mentor kullanım kılavuzu

Bu kılavuz, Windsurf veya GitHub Copilot kullanırken repository understanding, task delivery, code review ve kalıcı öğrenme workflow'unu açıklar.

## 1. Kurulumu doğrulama

Beklenen skill yapısı:

```text
~/.agents/skills/
├── engineering-mentor/
│   └── SKILL.md
└── teach/
    └── SKILL.md
```

Beklenen hafıza yapısı:

```text
~/.ai-learning/backend-engineering/
├── learner/
├── repositories/
└── active/
```

Eski `ai-native-task-tutor` veya `diagnosing-bugs` kurulumu varsa bootstrap bunu bildirir fakat veri kaybı yaratmamak için silmez. Yolun gerçekten bu paketin eski kurulumu olduğunu doğruladıktan sonra şirket bilgisayarındaki normal dosya yönetimi prosedürüyle kaldır.

## 2. Araçlara tanıtma

Hem Windsurf hem Copilot `~/.agents/skills/` yolunu kişisel/global skill konumu olarak keşfedebilir. Uygulamayı kurulumdan sonra yeniden başlat.

Her codebase çalışmasında mentorun otomatik seçilmesi için [prompts/global-rule.md](prompts/global-rule.md) içeriğini:

- Windsurf'te global Rule/Instructions alanına;
- Copilot'ta global custom instructions alanına

ekle. Global rule kısa kalır; ayrıntılı workflow ihtiyaç anında skill'den yüklenir.

## 3. Her yeni chat'te ne olur?

`engineering-mentor`:

1. Repo kimliğini belirler.
2. `learner/` altındaki mastery ve tercihleri okur.
3. Bu repo için daha önce kaydedilmiş mimari ve flow bilgisini okur.
4. `active/` altında yarım kalan session varsa gösterir.
5. İsteği dört moddan birine yönlendirir.
6. İlk anlamsal bloğu veya read-only keşif alanını önerir.

Windsurf hakkı bittiğinde Copilot'a veya tersi yönde geçebilirsin. Yeni araç ortak state'i okuyarak devam eder. Eşzamanlı kullanım ve lead-tool mekanizması tasarlanmamıştır.

## 4. Repository understanding

Başlangıç prompt'u:

```text
Use the engineering-mentor skill in repository-understanding mode.
Bu repoyu değiştirmeden anlamak istiyorum. Önce ortak hafızamı yükle,
sonra mimariyi, ana akışları ve gerekli kavramları çıkar.
```

Mentor taramayı katmanlı yapar:

1. Repository instructions, README ve build dosyaları.
2. Runtime entry point ve configuration.
3. Temsilî bir end-to-end flow.
4. Bu flow'un beklenen davranışını gösteren testler.
5. Mimarinin şeklini değiştiren diğer önemli flow'lar.

Tarama sonunda şu ayrımı üretir:

```text
Required now  — ana flow'u açıklamak için zorunlu
Required soon — bir sonraki derinlik veya task için gerekli
Later         — repoda var fakat şu anda ilerlemeyi engellemiyor
```

Sonra mastery ile karşılaştırır. Bütün listeyi öğretmez; seçilen flow'u anlamanı engelleyen en küçük kavram için `teach`i çağırır.

Repository understanding read-only'dir. Kod değişikliği ayrı bir task ve onay gerektirir.

## 5. Teach otomatik delegation

Mentorun handoff'u şu bilgileri içerir:

```text
Parent mode:
Semantic block veya repository flow:
Concept:
Neden şimdi gerekli:
Repo içindeki öğretim yüzeyi:
Mevcut mastery kanıtı:
Bu gate için gereken sınır:
Şimdilik ertelenen ayrıntılar:
Başarı kanıtı:
```

`teach` şu kurallarla çalışır:

- Parent task'ı planlamaz veya implement etmez.
- Bir seferde tek kavrama odaklanır.
- Soruları birer birer sorar.
- Normal bir gate'te en fazla 1–3 yüksek sinyalli nedensel soru kullanır.
- Level 2–3 konuyu baştan anlatmadan önce retrieval/transfer kontrolü yapar.
- Bir açıklama verdiğinde veya yanlış mental modeli düzelttiğinde `learner/lessons/<concept>.html` dersini ve `lessons/index.html` indeksini oluşturur/günceller.
- “Anladım”, açıklamayı okumak veya yeşil build'i mastery saymaz.
- Yalnızca gösterilmiş ve sanitize edilmiş yetkinliği kaydeder.

Gate sonunda:

```text
Learning result: demonstrated | in-progress
Evidence: ...
Remaining gap: ...
Mastery update: yes | no
Lesson artifact: <absolute path>
```

`in-progress` sonucunda mentor implementasyona devam etmez.

## 6. Task delivery

Hazır prompt: [prompts/task-start.md](prompts/task-start.md).

Mentor önce şu ortak modeli kurar:

```text
Current behavior
Desired behavior
Acceptance criteria
Out of scope
Main flow
Failure paths
Validation
```

Ardından task'ı anlamsal bloklara ayırır. Anlamsal blok, dosya değil tek davranış veya boundary'dir.

Her blok:

```text
Orient
→ Teach if needed
→ Understanding check
→ Explicit approval
→ Focused implementation
→ Actual diff review
→ Explain-back
→ Focused verification and its limits
→ Memory checkpoint
```

### Orient

Mevcut davranış, değişecek sınır, en yakın repo örneği, hedef davranış ve bu bloğun neden şimdi geldiği gösterilir.

### Understanding ve approval

Gerekli kavram için `teach` sonucu alınır. Sen beklenen runtime etkisini kendi cümlenle açıklarsın. Mentor yalnızca bu blok için açık onay ister.

### Implementasyon

Yalnızca onaylanan scope değiştirilir. Yeni dependency, migration veya plan dışı ihtiyaç bulunursa mentor durur.

### Diff review

- Ne değişti ve neden?
- Runtime davranışı nasıl değişti?
- Alternatif neydi?
- Gerçekçi failure nedir?
- Eksik, gereksiz veya beklenmeyen diff var mı?

### Explain-back ve verification

Sen değişen akışı kendi cümlenle anlatırsın. Focused test/check çalıştırılır; bunun neyi kanıtladığı ve neyi kanıtlamadığı ayrı söylenir.

## 7. Her zaman ayrıca onay gerektirenler

- Plan dışı scope genişlemesi
- Yeni dependency
- Database migration
- External-system mutation
- Repository bilgisinin network üzerinden aktarılması
- Destructive action
- Branch değiştirme
- Commit, push, merge veya pull request

Bir blok için verilen onay sonraki bloğu kapsamaz.

## 8. Code veya diff review

Örnek:

```text
Use engineering-mentor in code-review mode. Değişiklik yapma.
Bu diff'i anlamsal davranışlara ayır, gerçek koddan önceki ve sonraki
flow'u kur, gerekli kavramları teach'e devret ve Spec ile Standards'ı
ayrı değerlendir.
```

Mentor dosyaları alfabetik gezmek yerine hunk'ları davranışlara bağlar. Fix istenmedikçe read-only kalır.

## 9. Direct learning

Örnek:

```text
Use engineering-mentor. Bu repodaki örnek üzerinden Spring transaction
boundary'sini öğrenmek istiyorum.
```

Mentor uygun repository yüzeyini bulur ve öğretimi `teach`e devreder. Öğrenmek için yapay bir implementasyon task'ı oluşturmaz.

## 10. Hafıza güncellemesi

`learner/MASTERY.md` yalnızca kanıtlanan yetkinliği tutar. `learner/LEARNING-QUEUE.md`, repoda görülen fakat henüz gerekli olmayan kavramları tutar. Repository-specific detaylar `repositories/<repo-id>/` altında kalır.

Her tamamlanan anlamsal bloktan sonra `active/<repo-id>.md` şunları taşımalıdır:

```text
Mode
Goal
Observed revision
Completed semantic blocks
Current block
Approved scope
Learning gates passed
Open learning gaps
Validation already run
Open risks/questions
Next proposed action
```

Bu kayıt, yeni chat'te önceki konuşma metnine ihtiyaç duymadan devam etmeyi sağlar.

## 11. Kapanış standardı

```text
Delivery
- Status
- Spec
- Standards
- Validation
- Remaining risk

Learning
- Status
- Demonstrated concepts
- Mastery changes
- Open gap
- Next proof
```

Delivery tamamlanmışken Learning devam ediyor olabilir veya tersi olabilir. İki sonuç birleştirilmez.

## 12. Sorun giderme

### Mentor otomatik seçilmiyor

1. `~/.agents/skills/engineering-mentor/SKILL.md` bulunduğunu doğrula.
2. Uygulamayı yeniden başlat.
3. Global rule'u ekle.
4. Windsurf'te `@engineering-mentor`, Copilot'ta açık skill çağrısı kullan.

### Teach otomatik devreye girmiyor

`teach` skill'inin kurulu olduğunu ve frontmatter description'ının öğrenme gap'lerini kapsadığını doğrula. Mentora şunu söyle:

```text
Bu kavramı parent workflow içinde öğretme. Installed teach skill'ini invoke et
ve learning result dönmeden semantic block'a devam etme.
```

### AI hemen kod yazıyor

```text
Stop implementation. Return to engineering-mentor orientation.
Current semantic block için understanding ve approval gate geçilmedi.
```

### Yeni chat her şeyi baştan anlatıyor

`AI_LEARNING_HOME` değerini ve `active/<repo-id>.md` dosyasını doğrula. Araca önce learner, repository ve active state'i yüklemesini söyle.

### Çok fazla teori anlatılıyor

```text
Yalnızca mevcut flow veya semantic block'u anlamamı engelleyen en küçük
kavramı tut. Diğerlerini LEARNING-QUEUE içine al ve şimdi öğretme.
```
