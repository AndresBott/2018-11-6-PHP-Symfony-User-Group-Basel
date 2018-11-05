package main
import (
	//"net/http"
	//"log"
	//"io"
	//"io/ioutil"
	//"time"
	//"../goR/httpstat"
	"fmt"
)

//func requstPage(url string){
//
//	// Create a new HTTP request
//	req, err := http.NewRequest("GET", url, nil)
//	if err != nil {
//		log.Fatal(err)
//	}
//	// Create a httpstat powered context
//	var result httpstat.Result
//	ctx := httpstat.WithHTTPStat(req.Context(), &result)
//	req = req.WithContext(ctx)
//	// Send request by default HTTP client
//	client := http.DefaultClient
//	res, err := client.Do(req)
//	if err != nil {
//		log.Fatal(err)
//	}
//	if _, err := io.Copy(ioutil.Discard, res.Body); err != nil {
//		log.Fatal(err)
//	}
//	res.Body.Close()
//	end := time.Now()
//	// Show the results
//	log.Printf("DNS lookup: %d ms", int(result.DNSLookup/time.Millisecond))
//	log.Printf("TCP connection: %d ms", int(result.TCPConnection/time.Millisecond))
//	log.Printf("TLS handshake: %d ms", int(result.TLSHandshake/time.Millisecond))
//	log.Printf("Server processing: %d ms", int(result.ServerProcessing/time.Millisecond))
//	log.Printf("Content transfer: %d ms", int(result.ContentTransfer(time.Now())/time.Millisecond))
//	log.Printf("End: %s",end)
//	fmt.Print("s")
//}

func f(from string) {
	for i := 0; i < 3; i++ {
		fmt.Println(from, ":", i)
	}
}

func main() {

	go f("goroutine")
	//requstPage("http://google.es")

}


