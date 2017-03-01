## VIII. Eş Zamanlılık
### Süreç modeli yardımıyla dağıtıklaştırma

Herhangi bir bilgisayar programı bir kere çalıştığı zaman bir veya daha fazla süreç tarafından temsil edilir. Web uygulamaları çeşitli süreç çalışma formlarını alır. Örneğin, Php süreçleri Apache'nin çocuk süreçleri olarak çalışır, istek üzerine talep hacmine tarafından ihtiyaç duyulduğunda başlatılır. Java süreçleri, karşıt yaklaşımı benimser; JVM, başlangıçta çok sayıda sistem kaynağı (CPU ve bellek) ayıran büyük bir uber işlemi sağlar ve eşzamanlılık iş parçacıkları aracılığıyla dahili olarak yönetilir. Her iki durumda, çalışan süreçler, uygulamanın geliştiricilerine yalnızca minimum düzeyde görünürdür.

![Ölçek, çalışan süreçler olarak ifade edilir, iş yükü çeşitliliği, süreç tipi olarak tanımlanır.](/images/process-types.png)

**On iki faktör uygulamasında, süreçler birinci sınıf üyelerdir.** On iki faktör uygulamasındaki süreçler [arka planda çalışan servis programları için olan unix süreç modelinden](https://adam.herokuapp.com/past/2011/5/9/applying_the_unix_process_model_to_web_apps/) güçlü ipuçları alır. Bu modeli kullanarak geliştirici uygulamasını her bir tip işe bir *süreç tipi* atayarak, ayrı iş yüklerini kontrol etmek için uygulamasını planlayabilir. Örneğin, HTTP istekleri web süreçleri tarafından işlenir ve uzun çalışan arkaplan görevleri, işçi süreçler tarafından işlenir.

Bu, bireysel süreçlerin kendi dahili çoklu işlemelerini içermiyor değil, çalışma zamanı içindeki iş parçacıkları aracılığıyla VM, veya [EventMachine](http://rubyeventmachine.com/), [Twisted](http://twistedmatrix.com/trac/), [Node.js](http://nodejs.org/) gibi araçlarda bulunan asenkron model. Fakat bireysel VM yalnızca çok aşırı büyüyebilir (dikey ölçekte), bu yüzden uygulama aynı zamanda çoklu fiziksel makinelerde çalışan çoklu süreçleri içerebilmelidir.

Bu süreç modeli, konu ölçeklendirme zamanına geldiğinde gerçekten çok başarılıdır. Paylaşımsız, yatay olarak bölümlenebilir bir doğası olan on iki faktör uygulama süreçleri, daha fazla eş zamanlılık eklemenin kolay ve güvenilir bir işlem olduğu anlamına gelir. Süreç tipleri dizisi ve her bir tipin süreçlerinin numarası *süreç oluşumu* olarak bilinir.

On iki faktör uygulama süreçleri [asla arka planda çalışmamalı](http://dustin.github.com/2010/02/28/running-processes.html) ya da PID dosyalarını yazmamalıdır. Bunun yerine, [çıktı akışlarını](./logs) kontrol etmek, çökmüş süreçlere cevap vermek, kullanıcı başlatımlı tekrar başlatma ve kapatmaları işlemek için işletim sistemlerinin süreç yöneticisine( [Upstart](http://upstart.ubuntu.com/) gibi bulut platformunda yayınlanmış süreç yöneticisi veya geliştirme sürecinde [Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html)'e benzer araçlar ) dayanır.
