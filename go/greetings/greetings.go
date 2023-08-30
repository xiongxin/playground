package greetings

import (
	"errors"
	"fmt"
	"math/rand"
	"time"
)

func init() {
	rand.New(rand.NewSource(time.Now().UnixNano()))
}

func Hello(name string) (string, error) {
	if name == "" {
		return "", errors.New("empty name")
	}

	msg := fmt.Sprintf(ranndomFormat(), name)
	return msg, nil
}

func Hellos(names []string) (map[string]string, error) {
	messages := make(map[string]string)

	for _, name := range names {
		message, err := Hello(name)
		if err != nil {
			return nil, err
		}

		messages[name] = message
	}

	return messages, nil
}

func ranndomFormat() string {
	formats := []string{
		"Hi, %v. Welocome!",
		"Great to see you, %v!",
		"Hail, %v! Well met!",
	}
	return formats[rand.Intn(len(formats))]
}
