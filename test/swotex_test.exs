defmodule SwotExTest do
  use ExUnit.Case, async: true

  test "recognizes academic email addresses and domains" do
    assert_academic("lreilly@stanford.edu")
    assert_academic("LREILLY@STANFORD.EDU")
    assert_academic("Lreilly@Stanford.Edu")
    assert_academic("lreilly@slac.stanford.edu")
    assert_academic("lreilly@strath.ac.uk")
    assert_academic("lreilly@soft-eng.strath.ac.uk")
    assert_academic("lee@ugr.es")
    assert_academic("lee@uottawa.ca")
    assert_academic("lee@mother.edu.ru")
    assert_academic("lee@ucy.ac.cy")

    refute_academic("lee@leerilly.net")
    refute_academic("lee@gmail.com")
    refute_academic("lee@stanford.edu.com")
    refute_academic("lee@strath.ac.uk.com")

    assert_academic("stanford.edu")
    assert_academic("slac.stanford.edu")
    assert_academic("www.stanford.edu")
    assert_academic("http://www.stanford.edu")
    assert_academic("https://www.stanford.edu")
    assert_academic("//www.stanford.edu")
    assert_academic("http://www.stanford.edu:9393")
    assert_academic("strath.ac.uk")
    assert_academic("soft-eng.strath.ac.uk")
    assert_academic("ugr.es")
    assert_academic("uottawa.ca")
    assert_academic("mother.edu.ru")
    assert_academic("ucy.ac.cy")

    refute_academic("leerilly.net")
    refute_academic("gmail.com")
    refute_academic("stanford.edu.com")
    refute_academic("strath.ac.uk.com")

    refute_academic(nil)
    refute_academic("")
    refute_academic("the")

    assert_academic(" stanford.edu")
    assert_academic("lee@strath.ac.uk ")
    refute_academic(" gmail.com ")

    assert_academic("lee@stud.uni-corvinus.hu")

    # overkill
    assert_academic("lee@harvard.edu")
    assert_academic("lee@mail.harvard.edu")
  end

  test "not err on tld-only domains" do
    refute_academic(".com")
  end

  test "does not err on invalid domains" do
    refute_academic("foo@bar.invalid")
  end

  test "fail blacklisted domains" do
    ["si.edu", " si.edu ", "imposter@si.edu", "foo.si.edu", "america.edu", "folger.edu"]
    |> Enum.each(fn domain ->
      refute_academic(domain)
    end)
  end

  test "returns name of valid institution" do
    assert "University of Strathclyde", SwotEx.institution_name("lreilly@cs.strath.ac.uk")
    assert "BRG Fadingerstraße Linz, Austria", SwotEx.institution_name("lreilly@fadi.at")
  end

  test "returns nil when institution invalid" do
    refute SwotEx.institution_name("foo@shop.com")
  end

  defp assert_academic(domain) do
    assert SwotEx.is_academic?(domain), "#{domain} should be confirmed"
  end

  defp refute_academic(domain) do
    refute SwotEx.is_academic?(domain), "#{domain} should be denied"
  end
end
