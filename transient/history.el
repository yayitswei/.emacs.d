((gptel--infix-max-tokens "1000" 500 "500" long "long")
 (gptel--infix-provider #s(gptel-gemini "Gemini" "generativelanguage.googleapis.com" nil "https" t "/v1beta/models"
                                        (lambda nil
                                          (string-trim
                                           (shell-command-to-string "security find-generic-password -s anthropic-api-key -w")))
                                        (gemini-1.5-pro-latest gemini-2.0-flash-exp gemini-1.5-flash gemini-1.5-flash-8b gemini-exp-1206 gemini-pro gemini-2.0-flash gemini-2.0-flash-lite-preview-02-05 gemini-2.0-pro-exp-02-05 gemini-2.0-flash-thinking-exp-01-21 gemini-2.0-flash-exp gemini-2.0-flash-thinking-exp)
                                        #[0 "\303\203\f \f\203\f \306\202 \307\310\311\301\302\300\312 &\207"
                                            ["/v1beta/models" "https" "generativelanguage.googleapis.com" t gptel-stream gptel-model "streamGenerateContent" "generateContent" format "%s://%s%s/%s:%s?key=%s" gptel--get-api-key]
                                            9]
                                        nil nil)
                        #s(gptel-anthropic "Claude" "api.anthropic.com"
                                           #[0 "\300 \211\205 \301B\302B\207"
                                               [gptel--get-api-key "x-api-key"
                                                                   (("anthropic-version" . "2023-06-01")
                                                                    ("anthropic-beta" . "pdfs-2024-09-25")
                                                                    ("anthropic-beta" . "prompt-caching-2024-07-31"))]
                                               3]
                                           "https" t "/v1/messages"
                                           (lambda nil
                                             (string-trim
                                              (shell-command-to-string "security find-generic-password -s anthropic-api-key -w")))
                                           (claude-3-7-sonnet-20250219 claude-3-5-sonnet-20241022 claude-3-5-sonnet-20240620 claude-3-5-haiku-20241022 claude-3-opus-20240229 claude-3-sonnet-20240229 claude-3-haiku-20240307)
                                           "https://api.anthropic.com/v1/messages" nil nil))
 (gptel-menu nil
             ("k")
             ("b*gptel-context*")
             ("m"))
 (gptel-system-prompt nil)
 (transient:gptel-menu:b))
