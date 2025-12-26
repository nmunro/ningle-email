# ningle-email 0.2.0

## Author

nmunro

## Description

`ningle-email` is a simple package to simplify sending email, it provides functions for sending email and has multiple configurable backends for different purposes, backends are defined via [envy-ningle](https://github.com/nmunro/envy-ningle).

## Usage

{% highlight common_lisp %}
;; To mail admins
(mail-admins "Mailing admins" "This is a test email that should email all admins")

;; To mail a specific user
(send-mail "Mailing user" "This is a test email" "someone@somewhere.com")
{% endhighlight %}

## Configuration

Configuration is done by setting all of the following required flags and whichever additional ones are required.

### Configuration flags


| Name                   | Description                                           | Required? |
|------------------------|-------------------------------------------------------|-----------|
| project-name           | Used to identify the service the emails are sent from | Yes       |
| email-backend          | Sets the email backend to use                         | Yes       |
| email-default-from     | Sets the email "from" field                           | Yes       |
| email-admins           | The "admins" who get emailed from `mail-admins`       | Yes       |
| email-smtp-host        | The email smtp host                                   | No        |
| email-port             | The email port (or 587)                               | No        |
| email-ssl              | The email ssl setting (or :starttls)                  | No        |
| email-auth             | The email auth settings for a given service           | No        |
| email-sendgrid-api-key | The sendgrid api key                                  | No        |


### Available Backends

| Name     | Description                                               |
|----------|-----------------------------------------------------------|
| console  | Print the email to the console                            |
| string   | Render the email template as a string, useful for testing |
| smtp     | Sends email using smtp                                    |
| sendgrid | Sends email using the sendgrid service                    |

## Licence

BSD3-Clause
