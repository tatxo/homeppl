resource "aws_route53_zone" "main" {
  name = "tatxo.com"
}

resource "aws_route53_record" "web" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "web.tatxo.com"
  type    = "CNAME"
  ttl     = "30"
  records = [aws_elb.homeppl-elb.dns_name]
}
